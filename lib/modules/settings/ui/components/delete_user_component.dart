import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteUserButton extends ConsumerWidget {
  const DeleteUserButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                title: const Text('Delete my account?'),
                content: const Text('Warning: this action is irreversible'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Yes, delete'),
                    onPressed: () {
                      ref
                          .read(userStateNotifierProvider.notifier)
                          .deleteAccount();
                    },
                  ),
                ],
              );
            });
      },
      child: const Text("I want to delete my account"),
    );
  }
}
