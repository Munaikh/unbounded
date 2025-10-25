import 'package:apparence_kit/core/widgets/buttons.dart';
import 'package:apparence_kit/core/widgets/page_background.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/authentication/providers/models/email.dart';
import 'package:apparence_kit/modules/authentication/providers/models/password.dart';
import 'package:apparence_kit/modules/authentication/providers/models/signin_state.dart';
import 'package:apparence_kit/modules/authentication/providers/signin_state_provider.dart';
import 'package:apparence_kit/modules/authentication/ui/components/apple_signin.dart';
import 'package:apparence_kit/modules/authentication/ui/components/facebook_signin.dart';
import 'package:apparence_kit/modules/authentication/ui/components/google_signin.dart';
import 'package:apparence_kit/modules/authentication/ui/widgets/round_signin.dart';
import 'package:apparence_kit/modules/authentication/ui/widgets/social_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:universal_io/io.dart';

final _formKey = GlobalKey<FormState>();

class SigninPage extends ConsumerWidget {
  final bool canDismiss;

  const SigninPage({super.key, this.canDismiss = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signinStateProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        child: PopScope(
          canPop: canDismiss,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Background(
              child: Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 72),
                      Text(
                        'Welcome back',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        key: const Key('email_input'),
                        onChanged:
                            (value) => ref
                                .read(signinStateProvider.notifier)
                                .setEmail(value),
                        decoration: const InputDecoration(
                          hintText: 'bruce@wayne.com',
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          try {
                            state.email.validate();
                          } on EmailException catch (e) {
                            return e.message;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        key: const Key('password_input'),
                        onChanged:
                            (newValue) => ref
                                .read(signinStateProvider.notifier)
                                .setPassword(newValue),
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                        ),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        validator: (value) {
                          try {
                            state.password.validate();
                          } on PasswordException catch (e) {
                            return e.message;
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.push('/recover_password');
                          },
                          child: const Text(
                            "I lost my password",
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        key: const Key('send_button'),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          // hide keyboard
                          FocusScope.of(context).unfocus();
                          ref
                              .read(signinStateProvider.notifier)
                              .signin()
                              .then(
                                // ignore: use_build_context_synchronously
                                (value) => context.go('/'),
                                onError:
                                    (err) => showErrorToast(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      title: 'Error',
                                      text:
                                          'Wrong email, password or this email is not registered',
                                    ),
                              );
                        },
                        child: switch (state) {
                          SigninStateData() => const Text('Create my account'),
                          SigninStateSending() => const ButtonLoading(),
                        },
                      ),
                      const SizedBox(height: 4),
                      TextButton(
                        onPressed: () {
                          context.pushReplacement('/signup');
                        },
                        child: const Text("Don't have an account?"),
                      ),
                      const SizedBox(height: 32),
                      const SocialSeparator(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // remove the components you don't need
                          const GoogleSignInComponent(),
                          // will only be visible on Android
                          if (Platform.isAndroid)
                            const GooglePlayGamesSignInComponent(),
                          // will only be visible on iOS
                          const AppleSigninComponent(),
                          const FacebookSigninComponent(),
                          // not yet implemented in the CLI
                          SocialSigninButton.twitter(() {
                            throw UnimplementedError();
                          }),
                          // not yet implemented in the CLI
                          SocialSigninButton.microsoft(() {
                            throw UnimplementedError();
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
