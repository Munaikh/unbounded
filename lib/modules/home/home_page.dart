import 'package:apparence_kit/core/location/providers/user_location_provider.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/modules/activities/large_card.dart';
import 'package:apparence_kit/modules/activities/providers/all_activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // you can fetch the user state like this
    // final userState = ref.watch(userStateNotifierProvider);
    final activities = ref.watch(allActivitiesProvider);
    return Scaffold(
      extendBody: true,
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ListView(
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(30)),
                  color: context.colors.errorContainer.withCustomOpacity(0.3),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Ionicons.time_outline, size: 40, color: context.colors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Plan in 30 seconds', style: context.textTheme.titleMedium),
                          Flexible(
                            flex: 0,
                            child: Text(
                              'Answer 5 quick questions tailored picks',
                              style: context.textTheme.titleSmall?.copyWith(
                                color: context.colors.onSurface.withCustomOpacity(0.6),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push('/personalization');
                                },
                                child: PressableScale(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: ShapeDecoration(
                                      shape: RoundedSuperellipseBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      color: context.colors.primary,
                                    ),
                                    child: Text(
                                      'Personalize',
                                      style: context.textTheme.titleSmall?.copyWith(
                                        color: context.colors.background,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Top picks for you',
                style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              FutureBuilder(
                future: ref.watch(userLocationProvider.notifier).getUserLocation(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox.shrink();
                  }
                  if (asyncSnapshot.hasData) {
                    return activities.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      data: (activity) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: activity.length,
                        itemBuilder: (context, index) {
                          final act = activity[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: LargeCard(
                              id: act.id,
                              imageUrl: act.imageUrl ?? '',
                              title: act.name,
                              description: act.description ?? '',
                              price: act.cost ?? 0,
                              minGroupSize: activity[index].minGroupSize ?? 0,
                              maxGroupSize: activity[index].maxGroupSize ?? 0,
                              distance: act.location ?? '',
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
