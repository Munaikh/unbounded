import 'package:flutter/material.dart';

class SocialSeparator extends StatelessWidget {
  const SocialSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.black12),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Or sign in with",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const Expanded(
          child: Divider(color: Colors.black12),
        ),
      ],
    );
  }
}
