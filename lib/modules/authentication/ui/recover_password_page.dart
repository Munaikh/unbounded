import 'package:apparence_kit/core/widgets/field.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/authentication/providers/models/email.dart';
import 'package:apparence_kit/modules/authentication/providers/models/recover_state.dart';
import 'package:apparence_kit/modules/authentication/providers/recover_provider.dart';
import 'package:apparence_kit/modules/authentication/ui/widgets/recover_password_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formKey = GlobalKey<FormState>();

class RecoverPasswordPage extends ConsumerWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recoverStateProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: switch (state) {
              RecoverStateData() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 72),
                      Text(
                        'Recover password',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 24),
                      AppFormField(
                        formKey: const Key('email_input'),
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          try {
                            state.email.validate();
                          } on EmailException catch (e) {
                            return e.message;
                          }
                          return null;
                        },
                        onChanged:
                            (value) => ref
                                .read(recoverStateProvider.notifier)
                                .setEmail(value),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        key: const Key('recover_button'),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          ref
                              .read(recoverStateProvider.notifier)
                              .send()
                              .catchError(
                                (e, trace) => showErrorToast(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  title: 'Error',
                                  text: 'Fill a valid email',
                                ),
                              );
                        },
                        child: const Text('Recover password'),
                      ),
                    ],
                  ),
                ),
              ),
              RecoverStateSending() => Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
              RecoverStateSent() => const RecoverPasswordSent(),
            },
          ),
        ),
      ),
    );
  }
}
