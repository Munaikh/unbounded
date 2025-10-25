import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons.dart';
import 'package:apparence_kit/core/widgets/responsive_layout.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/authentication/providers/models/email.dart';
import 'package:apparence_kit/modules/authentication/providers/models/password.dart';
import 'package:apparence_kit/modules/authentication/providers/models/signup_state.dart';
import 'package:apparence_kit/modules/authentication/providers/signup_state_provider.dart';
import 'package:apparence_kit/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();

class SignupPage extends ConsumerWidget {
  final bool canDismiss;

  const SignupPage({super.key, this.canDismiss = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SizedBox(
        child: PopScope(
          canPop: canDismiss,
          child: Scaffold(
            backgroundColor: context.colors.background,
            resizeToAvoidBottomInset: false,
            body: ResponsiveLayout(
              small: const SignupForm(),
              medium: Center(
                child: Container(
                  width: 400,
                  height: 480,
                  color: context.colors.surface,
                  padding: const EdgeInsets.all(24.0),
                  child: const SignupForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends ConsumerWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupStateProvider);
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(height: 72),
            Text(
              'Signup now',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 32),
            TextFormField(
              key: const Key('email_input'),
              onChanged:
                  (value) =>
                      ref.read(signupStateProvider.notifier).setEmail(value),
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
                      .read(signupStateProvider.notifier)
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
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('send_button'),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                // hide keyboard
                FocusScope.of(context).unfocus();
                // call signup method
                ref
                    .read(signupStateProvider.notifier)
                    .signup()
                    .then(
                      // ignore: use_build_context_synchronously
                      (_) => context.go('/'),
                      // we don't provide more details to the user about the error for security reasons
                      onError:
                          (err) => showErrorToast(
                            context: navigatorKey.currentContext!,
                            title: 'Error',
                            text: 'This email already exists or is invalid',
                          ),
                    );
              },
              child: switch (state) {
                SignupStateData() => const Text('Create my account'),
                SignupStateSending() => const ButtonLoading(),
              },
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: () {
                context.pushReplacement('/signin');
              },
              child: const Text("I already have an account"),
            ),
          ],
        ),
      ),
    );
  }
}
