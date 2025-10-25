import 'package:apparence_kit/core/data/api/analytics_api.dart';


import 'package:apparence_kit/core/initializer/onstart_widget.dart';
import 'package:apparence_kit/core/shared_preferences/shared_preferences.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/theme/providers/theme_provider.dart';
import 'package:apparence_kit/core/theme/texts.dart';
import 'package:apparence_kit/core/theme/universal_theme.dart';
import 'package:apparence_kit/environnements.dart';
import 'package:apparence_kit/firebase_options_dev.dart' as firebase_dev;
import 'package:apparence_kit/i18n/translations.g.dart';

import 'package:apparence_kit/modules/notifications/api/local_notifier.dart';
import 'package:apparence_kit/modules/notifications/repositories/notifications_repository.dart';

import 'package:apparence_kit/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  final env = Environment.fromEnv();
  final logger = Logger();
  logger.i('Starting app in ${env.name} mode');
  // I like to force portrait mode on mobile devices
  // What is the last time you used an app in landscape mode?
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // initialize shared preferences for theme
  final sharedPrefs = await SharedPreferences.getInstance();

  // initialize firebase app for notifications
  await switch(env) {
    DevEnvironment() => Firebase.initializeApp(
      options: firebase_dev.DefaultFirebaseOptions.currentPlatform,
    ),
    ProdEnvironment() => Firebase.initializeApp(
      // TODO replace with your own firebase options for production environment (if needed)
      options: firebase_dev.DefaultFirebaseOptions.currentPlatform,
    ),
  };

  // initialize supabase app
  await switch(env) {
    DevEnvironment(:final backendUrl) => Supabase.initialize(
      url: backendUrl,
      anonKey: const String.fromEnvironment('SUPABASE_TOKEN'),
    ),
    ProdEnvironment(:final backendUrl) => Supabase.initialize(
      url: backendUrl,
      anonKey: const String.fromEnvironment('SUPABASE_TOKEN'),
    ),
  };

  // initialize sentry for error reporting in production only
  // run the app with Sentry for production environment
  if (env is DevEnvironment) {
    run(sharedPrefs);
  } else if (env is ProdEnvironment) {
    SentryFlutter.init((options) {
      options.dsn = env.sentryDsn;
      // 20% of traces will be sent to Sentry server. You should start with 1 and decrease it once you have more users.
      options.tracesSampleRate = 0.2;
      options.environment = env.name;
    }, appRunner: () => run(sharedPrefs));
  }
  
  
}

void run(SharedPreferences prefs) => runApp(
      TranslationProvider(
        child: ProviderScope(
          child: MyApp(
            sharedPreferences: prefs,
          ),
        ),
      ),
    );


// use this if you want to define different themes for different platforms
// notifier: AppTheme.adaptive(
//   defaultTextTheme: ApparenceKitTextTheme.build(),
//   ios: const IosThemeFactory(),
//   android: const AndroidThemeFactory(),
//   web: const WebThemeFactory(),
//   lightColors: ApparenceKitColors.light(),
//   darkColors: ApparenceKitColors.dark(),
//   mode: ThemeMode.dark,
// ),
// See ./docs/theme.md for more details
class MyApp extends ConsumerWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return AppErrorWidget(error: details);
    };
    final goRouter = ref.watch(goRouterProvider);

    return ThemeProvider(
      notifier: AppTheme.uniform(
        sharedPreferences: sharedPreferences,
        themeFactory: const UniversalThemeFactory(),
        lightColors: ApparenceKitColors.light(),
        darkColors: ApparenceKitColors.dark(),
        textTheme: ApparenceKitTextTheme.build(),
        defaultMode: ThemeMode.light,
      ),
      child: Builder(builder: (context) {
        return MaterialApp.router(
          title: 'Flutter Pro Starter Kit',
          theme: ThemeProvider.of(context).light,
          darkTheme: ThemeProvider.of(context).dark,
          themeMode: ThemeProvider.of(context).mode,
          routerConfig: goRouter,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          // Initializer is a widget that allows us to run some code before the app is ready
          builder: (context, child) => Initializer(
            services: [
              
              // shared preferences must be loaded
              sharedPreferencesProvider,
              
              // notifications
              notificationsSettingsProvider,
              notificationRepositoryProvider,
              // user state
              
              userStateNotifierProvider.notifier,
              // analytics
              analyticsApiProvider,
              
            ],
            onReady: child!,
            onError: (_, error) => InitializationErrorPage(error: error),
            onLoading: const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// This is an example of a more user friendly error widget
/// By default Flutter will show a red screen with the error in debug mode
/// and a grey screen in release mode
class AppErrorWidget extends StatelessWidget {
  final FlutterErrorDetails? error;

  const AppErrorWidget({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.orangeAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Oups!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sorry, Something went wrong',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            '${error?.exception}\n',
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class InitializationErrorPage extends StatelessWidget {
  final String error;

  const InitializationErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Text(
              'Cannot start app',
              style: context.textTheme.titleLarge,
            ),
            Text(
              'Check your internet connection and start again',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colors.neutral300,
              ),
            ),
            if (kDebugMode) 
              Text(
                "developper mode error: $error",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}