import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecoverPasswordSent extends StatelessWidget {
  const RecoverPasswordSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Email sent',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.green,
                ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 250,
            child: Text(
              'We sent you an email with a link to reset your password',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: context.colors.onBackground,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: const Text("Get back to Sign in"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Note: If you don't receive an email, please check your spam folder",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: context.colors.onBackground,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
