import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

Future<FirebaseApp> initFirebaseForTest([int? counter]) async {
  try {
    setupFirebaseAuthMocks();
    return await Firebase.initializeApp(
      name: 'DEFAULT',
      options: const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
      ),
    );
  } catch (_) {}
  return Firebase.app();
}

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();
}
