import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
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
      
              SizedBox(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width) * .7,
                      margin: const EdgeInsets.only(right: 16),
      
                      decoration: ShapeDecoration(
                        shape: RoundedSuperellipseBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: context.colors.surface,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              'https://x-kart.co.uk/wp-content/uploads/2022/05/start-outdoor-karting.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Karting Glagow", style: context.textTheme.titleMedium),
                                const SizedBox(height: 4),
                                Text(
                                  "Active, Lively, Bookable",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colors.onSurface.withValues(alpha: .6),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 16, color: context.colors.primary),
                                    const SizedBox(width: 4),
                                    Text(
                                      "1.4 KM",
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        color: context.colors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      "\$22 pp",
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        color: context.colors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(Icons.group, size: 16, color: context.colors.primary),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Group 8-20",
                                      style: context.textTheme.bodyMedium?.copyWith(
                                        color: context.colors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Here is just a simple content card
class HomeCard extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String description;
  final Color? textColor;
  final Color? backgroundColor;

  const HomeCard({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        HapticFeedback.mediumImpact();
        onTap.call();
      },
      child: Card(
        color: backgroundColor ?? context.colors.primary.withValues(alpha: .15),
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                title,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: textColor ?? context.colors.onSurface,
                ),
              ),
              Text(
                description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color:
                      textColor ??
                      context.colors.onSurface.withValues(alpha: .6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
