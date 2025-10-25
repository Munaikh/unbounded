// ignore_for_file: avoid_redundant_argument_values

import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'environnements.freezed.dart';

const _kEnvironmentInput = String.fromEnvironment('ENV', defaultValue: 'dev');

const _kBackendUrl = String.fromEnvironment(
  'BACKEND_URL',
  // this URL is a fake backend to let you test the app without having to setup your own
  // it replies with fake data and is not meant to be used in production
  // please replace it with your own backend URL
  defaultValue: 'https://us-central1-apparencekit-pro.cloudfunctions.net/app',
);

final environmentProvider = Provider<Environment>(
  (ref) => Environment.fromEnv(),
);

/// The environment of the app.
/// - dev: Development environment
/// - prod: Production environment
/// Feel free to add more environments with your custom properties if needed.
@freezed
sealed class Environment with _$Environment {
  const factory Environment.dev({
    // Name of the environment (dev, prod, ...) just for debug purpose
    required String name,

    /// Url of your backend API / or Supabase URL / or Firebase Functions region
    required String backendUrl,

    /// RevenueCat API key for Android
    /// (only if you want to use in-app purchases with RevenueCat)
    String? revenueCatAndroidApiKey,

    /// RevenueCat API key for iOS
    /// (only if you want to use in-app purchases with RevenueCat)
    String? revenueCatIOSApiKey,

    /// this is used to open the app store page of your app for reviews
    String? appStoreId,

    /// only if you want to use ads
    String? androidInterstitialAdUnitId,

    /// only if you want to use ads
    String? iOSInterstitialAdUnitID,

    /// Environment variable to handle Mixpanel analytics
    /// You can get it from https://mixpanel.com
    String? mixpanelToken,

    /// The default authentication mode of the app (anonymous or authRequired)
    /// See [AuthenticationMode]
    required AuthenticationMode authenticationMode,
  }) = DevEnvironment;

  const factory Environment.prod({
    required String name,

    /// Url of your backend API / or Supabase URL / or Firebase Functions region
    required String backendUrl,

    /// RevenueCat API key for Android
    /// (only if you want to use in-app purchases with RevenueCat)
    String? revenueCatAndroidApiKey,

    /// RevenueCat API key for iOS
    /// (only if you want to use in-app purchases with RevenueCat)
    String? revenueCatIOSApiKey,

    /// only if you want to use ads
    String? androidInterstitialAdUnitId,

    /// only if you want to use ads
    String? iOSInterstitialAdUnitID,

    /// this is used to open the app store page of your app for reviews
    String? appStoreId,

    /// Sentry is an error reporting tool that will help you to track errors in production
    /// You can get it from https://sentry.io
    /// by default sentry will read the SENTRY_DSN environment variable except for web
    /// you can also setup it directly here. Prefer using environment variables
    String? sentryDsn,

    /// Environment variable to handle Mixpanel analytics
    /// You can get it from https://mixpanel.com
    String? mixpanelToken,

    /// The default authentication mode of the app (anonymous or authRequired)
    /// See [AuthenticationMode]
    required AuthenticationMode authenticationMode,
  }) = ProdEnvironment;

  const Environment._();

  factory Environment.fromEnv() {
    switch (_kEnvironmentInput) {
      case 'dev':
        return const Environment.dev(
          name: 'dev',
          backendUrl: _kBackendUrl,
          appStoreId: '',
          revenueCatAndroidApiKey: String.fromEnvironment(
            'RC_ANDROID_API_KEY',
            defaultValue: '',
          ),
          revenueCatIOSApiKey: String.fromEnvironment(
            'RC_IOS_API_KEY',
            defaultValue: '',
          ),
          mixpanelToken: String.fromEnvironment("MIXPANEL_TOKEN"),
          authenticationMode: AuthenticationMode.anonymous,
          
        );
      case 'prod':
        return const Environment.prod(
          name: 'production',
          backendUrl: _kBackendUrl,
          appStoreId: String.fromEnvironment('APP_STORE_ID'),
          revenueCatAndroidApiKey: String.fromEnvironment(
            'RC_ANDROID_API_KEY',
            defaultValue: '',
          ),
          revenueCatIOSApiKey: String.fromEnvironment(
            'RC_IOS_API_KEY',
            defaultValue: '',
          ),
          sentryDsn: String.fromEnvironment('SENTRY_DSN'),
          mixpanelToken: String.fromEnvironment("MIXPANEL_TOKEN"),
          authenticationMode: AuthenticationMode.anonymous,
          
        );
      default:
        throw Exception('Unknown environment $_kEnvironmentInput');
    }
  }
}

/// This callback is called when the app is launched.
typedef OnEnvCallback = Future<void> Function();
