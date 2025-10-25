import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/modules/activities/large_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// this homepage is for demo purpose only
/// You can delete it and start from scratch
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // you can fetch the user state like this
    // final userState = ref.watch(userStateNotifierProvider);
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Text("Home page", style: context.textTheme.headlineLarge),
              Text(
                'Welcome on the ApparenceKit demo',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  color: context.colors.onBackground,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              const LargeCard(
                imageUrl: 'https://x-kart.co.uk/wp-content/uploads/2022/05/start-outdoor-karting.jpg',
                title: 'Karting Glagow',
                description: 'Active, Lively, Bookable',
                distance: '1.4 KM',
                price: '22',
                groupSize: '8-20',
              ),
            ],
          ),
        ),
      ),
    );
  }
}