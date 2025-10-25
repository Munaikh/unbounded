import 'package:apparence_kit/core/data/models/subscription.dart';
import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/data/repositories/user_repository.dart';
import 'package:apparence_kit/core/initializer/onstart_service.dart';
import 'package:apparence_kit/core/states/models/user_state.dart';
import 'package:apparence_kit/environnements.dart';
import 'package:apparence_kit/modules/authentication/repositories/authentication_repository.dart';
import 'package:apparence_kit/modules/notifications/providers/models/device.dart';
import 'package:apparence_kit/modules/notifications/repositories/device_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'user_state_notifier.g.dart';

/// Use this provider to access the user state (legacy name)
const userStateNotifierProvider = userStateProvider;

/// This enum is used to parameter the list of the authentication mode
///
/// Most of apps try to not force user to create an account to access the app
/// But you may want to force the user to be authenticated to access the app
enum AuthenticationMode {
  /// By default the user will be authenticated anonymously
  /// This means that the user can access your app without login
  /// He will be able to link his account later to an email or social login
  anonymous,

  /// The user requires to be authenticated to access the app
  /// By default the user won't have any identity
  authRequired,
}

/// This class is responsible for managing the state of the user over the app.
/// It will be used to know if the user is connected or not and to get the user
@Riverpod(keepAlive: true)
class UserStateNotifier extends _$UserStateNotifier implements OnStartService {
  Logger get _logger => Logger();

  AuthenticationRepository get _authenticationRepository =>
      ref.read(authRepositoryProvider);

  DeviceRepository get _deviceRepository => ref.read(deviceRepositoryProvider);

  UserRepository get _userRepository => ref.read(userRepositoryProvider);

  /// The authentication mode of the app
  /// see [AuthenticationMode]
  AuthenticationMode get mode =>
      ref.read(environmentProvider).authenticationMode;

  @override
  UserState build() {
    return const UserState(user: User.loading());
  }

  @override
  Future<void> init() async {
    try {
      await _loadState();
    } catch (e, stacktrace) {
      _logger.e(e, stackTrace: stacktrace);
      if(kDebugMode) {
        // we automatically logout the user if an error occurs in debug mode
        // customize this behavior to fit your needs
        _authenticationRepository.logout();
      }
      rethrow;
    }
    assert(state.user is! LoadingUserData, 'UserStateNotifier is not ready');
    await _initDeviceRegistration();
    _deviceRepository.onTokenUpdate(_onUpdateToken);
  }

  /// This function is called when the user click on the signin button
  /// It will load the user state and register the device to the notification service
  /// It will also load the subscription state
  Future<void> onSignin() async {
    state = const UserState(
      user: User.loading(),
    );
    await _loadState();
    await _initDeviceRegistration();
  }

  /// Set the user as onboarded in the database
  /// This function is called when the user has completed the onboarding
  Future<void> onOnboarded() async {
    final newUser = await _userRepository.setOnboarded(state.user);
    state = state.copyWith(user: newUser);
  }

  /// This function is called when the user click on the logout button
  /// It will unregister the device from the notification service
  /// and logout the user
  Future<void> onLogout() async {
    final userId = state.user.idOrThrow;
    _deviceRepository.removeTokenUpdateListener();
    await _deviceRepository.unregister(userId);
    await _authenticationRepository.logout();
    state = const UserState(
      user: User.anonymous(),
    );
    if (mode == AuthenticationMode.anonymous) {
      await _loadAnonymousState();
    }
  }

  /// Refresh the user
  Future<void> onUpdateAvatar() async {
    await refresh();
  }

  /// Refresh the user
  Future<void> refresh() async {
    final user = await _userRepository.get(state.user.idOrThrow);

    state = state.copyWith(
      user: user ?? const User.anonymous(),
    );
  }

  

  /// Apple store and Google play stores requires you to be able to delete a user account on demand
  /// Here is the function to do it.
  /// It will delete the user account and logout the user
  Future<void> deleteAccount() async {
    try {
      final userId = state.user.idOrThrow;
      _deviceRepository.removeTokenUpdateListener();
      await _deviceRepository.unregister(userId);
      await _userRepository.delete();
      await _authenticationRepository.logout();
    } catch (e) {
      _logger.e(e);
    }
    state = const UserState(
      user: User.anonymous(),
    );

    if (mode == AuthenticationMode.anonymous) {
      await _loadAnonymousState();
    }
  }

  // -------------------------------
  // PRIVATES
  // -------------------------------

  /// load anonymous state for the user
  Future<void> _loadAnonymousState() async {
    await _authenticationRepository.signupAnonymously();
    await Future.delayed(const Duration(seconds: 1));
    final credentials = await _authenticationRepository.get();
    var user = await _userRepository.get(credentials!.id);
    // We retry to get the user 3 times (sometimes the user creation trigger is not fast enough)
    var retry = 0;
    while (user == null && retry < 3) {
      await Future.delayed(const Duration(seconds: 1));
      user = await _userRepository.get(credentials.id);
      retry++;
    }
    // if the user is still null you certainly have an issue with your user creation trigger
    if (user == null) {
        throw Exception('''
User infos not found. If you are using firebase \r\n 
- Check that you have correctly installed firebase functions
If you are using supabase
- Check that you have properly run the setup script
        ''');
    }
    state = state.copyWith(user: user);
  }

  /// Load the state of the user
  Future<void> _loadState() async {
    final credentials = await _authenticationRepository.get();

    if (credentials == null && mode == AuthenticationMode.anonymous) {
      _logger.i('Anonymous user mode activated, signup anonymously');
      await _loadAnonymousState();
    } else if (credentials == null && mode == AuthenticationMode.authRequired) {
      _logger.i('Authentification required, user is not connected');
      state = state.copyWith(user: const User.anonymous());
    } else if (credentials != null) {
      _logger.i('User is connected with id ${credentials.id}');
      // I like to save a User automatically when the user is authenticated
      // Using firestore you can create a trigger to do this with the same document ID as the credentials
      final user = await _userRepository.get(credentials.id);
      if (user == null) {
        throw Exception('''
User infos not found. If you are using firebase \r\n 
- Check that you have correctly installed firebase functions
If you are using supabase
- Check that you have properly run the setup script
        ''');
      }
      state = state.copyWith(user: user);
    }
  }

  /// If user has an ID we will register his device to send notifications from
  /// the server to the device (only if user has accepted them)
  /// Maybe save your device in UserState if you need it in your app
  Future<void> _initDeviceRegistration() async {
    final userId = state.user.idOrNull;
    if (userId == null) {
      return;
    }
    try {
      final _ = await _deviceRepository.register(userId);
    } catch (err, stacktrace) {
      _logger.e(err, stackTrace: stacktrace);
      _logger.e('''
          ❌ Your device seems not to be registered.
          Check that you correctly setup a device registration API
          see: `lib/modules/notifications/api/device_api.dart`
        ''');
    }
  }

  /// This function is called when the device token is updated
  /// It will update the token in the database
  Future<void> _onUpdateToken(Device device) async {
    await _deviceRepository.updateToken(device.token);
  }
}
