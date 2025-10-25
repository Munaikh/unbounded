import 'package:flutter/material.dart';

class EmptyNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 72),
        SizedBox(
          width: 250,
          height: 250,
          child: Image.asset('assets/images/empty_notifications.jpg'),
        ),
        const SizedBox(height: 16),
        Text(
          'No notifications yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Stay tuned for updates',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
