// ignore_for_file: use_build_context_synchronously

import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/authentication/providers/signin_state_provider.dart';
import 'package:apparence_kit/modules/authentication/ui/widgets/round_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GoogleSignInComponent extends ConsumerWidget {
  const GoogleSignInComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialSigninButton.google(() => ref
            .read(signinStateProvider.notifier)
            .signinWithGoogle()
            .then(
              (value) => context.pushReplacement('/'),
            )
            .catchError(
          (err) {
            showErrorToast(
              context: context,
              title: 'Error',
              text: 'Cannot signin with Google',
            );
            return err;
          },
        ));
  }
}

class GooglePlayGamesSignInComponent extends ConsumerWidget {
  const GooglePlayGamesSignInComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialSigninButton.googlePlayGames(
      () => ref
          .read(signinStateProvider.notifier)
          .signinWithGoogle()
          .catchError(
            (err) => showErrorToast(
              context: context,
              title: 'Error',
              text: 'Cannot signin with Google play',
            ),
          )
          .then(
            (value) => context.pushReplacementNamed('/signup'),
          ),
    );
  }
}
