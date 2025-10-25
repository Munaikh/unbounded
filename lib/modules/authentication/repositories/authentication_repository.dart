import 'package:apparence_kit/core/data/api/base_api_exceptions.dart';
import 'package:apparence_kit/core/data/api/http_client.dart';
import 'package:apparence_kit/core/data/api/user_api.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/core/security/secured_storage.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api.dart';
import 'package:apparence_kit/modules/authentication/api/authentication_api_interface.dart';
import 'package:apparence_kit/modules/authentication/repositories/exceptions/authentication_exceptions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final authRepositoryProvider = Provider<AuthenticationRepository>(
  (Ref ref) => HttpAuthenticationRepository(
    logger: Logger(),
    authenticationApi: ref.read(authenticationApiProvider),
    storage: ref.read(authSecuredStorageProvider),
    userApi: ref.read(userApiProvider),
    httpClient: ref.read(httpClientProvider),
  ),
);

abstract class AuthenticationRepository {
  /// Signup a user anonymously
  /// The user is signed in with an ID
  /// but we don't have any information about him (email, name, ...)
  /// This allows him to have a temporary account that he can link to an email or social login later
  Future<void> signupAnonymously();

  /// Signup a user with [email] and [password]
  /// The user is signed in automatically
  /// We SHOULD NOT store the password in the database
  /// We stores the token in the secured storage
  /// throws [SignupException] if an error occurs
  Future<void> signup(String email, String password);

  /// Signin a user with [email] and [password]
  /// The user is signed in automatically
  /// We SHOULD NOT store the password in the database
  /// We stores the token in the secured storage
  /// throws [SigninException] if an error occurs
  Future<void> signin(String email, String password);

  /// Get the current user or null if not connected
  Future<Credentials?> get();

  /// Logout the current user
  /// We clear the token from the secured storage
  Future<void> logout();

  /// Signin with Google account
  Future<void> signinWithGoogle();

  /// Signin with Google Play Games account on Android
  Future<void> signinWithGooglePlayGames();

  /// Signin with Facebook account
  Future<void> signinWithFacebook();

  /// Signin with Apple account
  Future<void> signinWithApple();

  /// Recover password
  /// (send an email to the user with a link to reset the password)
  Future<void> recoverPassword(String email);

  /// Request a verification code to be sent to the provided phone number
  /// Returns a verification id that will be used to verify the code
  Future<String> signinWithPhone(String phoneNumber);

  /// Verify the phone number with the code sent to the user
  /// The user is signed in automatically if the verification is successful
  /// We store the token in the secured storage
  /// throws [PhoneAuthException] if an error occurs
  Future<void> verifyPhoneAuth(String verificationId, String otp);

  /// Update the phone number of the current user
  /// The user is signed in automatically if the verification is successful
  /// We store the token in the secured storage
  /// throws [PhoneAuthException] if an error occurs
  Future<String> updateAuthPhone(String phoneNumber);

  /// Confirm the link of a phone number to the current user
  /// The user is signed in automatically if the verification is successful
  /// We store the token in the secured storage
  /// throws [PhoneAuthException] if an error occurs
  Future<void> confirmLinkPhoneAuth(String verificationId, String otp);
}

/// this is an example on how to create an authentication repository using firebase
class HttpAuthenticationRepository implements AuthenticationRepository {
  final Logger _logger;
  final AuthenticationApi _authenticationApi;
  final AuthSecuredStorage _storage;
  // ignore: unused_field
  final UserApi _userApi;
  final HttpClient _httpClient;

  HttpAuthenticationRepository({
    required Logger logger,
    required AuthenticationApi authenticationApi,
    required AuthSecuredStorage storage,
    required UserApi userApi,
    required HttpClient httpClient,
  })  : _logger = logger,
        _httpClient = httpClient,
        _userApi = userApi,
        _authenticationApi = authenticationApi,
        _storage = storage;

  @override
  Future<void> signupAnonymously() async {
    try {
      _logger.d('Signup anonymously up');
      final credentials = await _authenticationApi.signinAnonymously();
      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw SignupException.fromApiError(e);
    } catch (e) {
      throw SignupException(
        code: 0,
        message: 'Unknown error $e',
      );
    }
  }

  @override
  Future<void> signup(String email, String password) async {
    try {
      _logger.d('Signing up with $email');
      final credentials = await _authenticationApi.signup(email, password);
      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw SignupException.fromApiError(e);
    } catch (e) {
      throw SignupException(
        code: 0,
        message: 'Unknown error $e',
      );
    }
  }

  @override
  Future<void> signin(String email, String password) async {
    try {
      _logger.d('Signing in with $email');
      final credentials = await _authenticationApi.signin(email, password);
      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw SigninException.fromApiError(e);
    } catch (e) {
      throw SigninException(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<void> recoverPassword(String email) async {
    try {
      await _authenticationApi.recoverPassword(email);
    } on ApiError catch (e) {
      throw RecoverPasswordException.fromApiError(e);
    } catch (e) {
      throw RecoverPasswordException(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<void> signinWithGoogle() async {
    try {
      _logger.d('Signing in with Google');
      final credentials = await _authenticationApi.signinWithGoogle();
      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw SigninException.fromApiError(e);
    } catch (e) {
      throw SigninException(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<void> signinWithGooglePlayGames() async {
    try {
      _logger.d('Signing in with Google play games');
      final credentials = await _authenticationApi.signinWithGooglePlay();
      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw SigninException.fromApiError(e);
    } catch (e) {
      throw SigninException(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<void> signinWithApple() async {
    try {
      _logger.d('Signing in with Apple');
      final credentials = await _authenticationApi.signinWithApple();
      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw SigninException.fromApiError(e);
    } catch (e) {
      throw SigninException(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<void> signinWithFacebook() async {
    try {
      _logger.d('Signing in with Facebook');
      final credentials = await _authenticationApi.signinWithFacebook();
      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw SigninException.fromApiError(e);
    } catch (e) {
      throw SigninException(
        code: 0,
        message: '$e',
      );
    }
  }

  @override
  Future<void> logout() async {
    _logger.d('Logging out');
    _httpClient.authToken = null;
    await _authenticationApi.signout();
    await _storage.clear();
  }

  @override
  
  Future<Credentials?> get() => _authenticationApi.get();
  

  @override
  Future<String> signinWithPhone(String phoneNumber) {
    try {
      _logger.d('Requesting phone authentication for $phoneNumber');
      return _authenticationApi.signinWithPhone(phoneNumber);
    } on ApiError catch (e) {
      throw PhoneAuthException.fromApiError(e);
    } catch (e) {
      throw PhoneAuthException(
        code: 0,
        message: 'Unknown error: $e',
      );
    }
  }

  @override
  Future<void> verifyPhoneAuth(String verificationId, String otp) async {
    try {
      _logger.d('Verifying phone code');
      final credentials = await _authenticationApi.verifyPhoneAuth(
        verificationId,
        otp,
      );

      await _storage.write(value: credentials);
      _httpClient.authToken = credentials.token;
    } on ApiError catch (e) {
      throw PhoneAuthException.fromApiError(e);
    } catch (e) {
      throw PhoneAuthException(
        code: 0,
        message: 'Unknown error: $e',
      );
    }
  }

  @override
  Future<String> updateAuthPhone(String phoneNumber) async {
    try {
      _logger.d('Updating phone number to $phoneNumber');
      return _authenticationApi.updateAuthPhone(phoneNumber);
    } on PhoneAlreadyLinkedException {
      rethrow;
    } on ApiError catch (e) {
      throw PhoneAuthException.fromApiError(e);
    } catch (e) {
      throw PhoneAuthException(
        code: 0,
        message: 'Unknown error: $e',
      );
    }
  }

  @override
  Future<void> confirmLinkPhoneAuth(String verificationId, String otp) async {
    try {
      _logger.d('Confirming link phone auth');
      await _authenticationApi.confirmLinkPhoneAuth(verificationId, otp);
    } on PhoneAlreadyLinkedException {
      rethrow;
    } on ApiError catch (e) {
      throw PhoneAuthException.fromApiError(e);
    } catch (e) {
      throw PhoneAuthException(
        code: 0,
        message: 'Unknown error: $e',
      );
    }
  }
}
