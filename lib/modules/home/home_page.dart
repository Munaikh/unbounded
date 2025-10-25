import 'package:apparence_kit/core/location/providers/user_location_provider.dart';
import 'package:apparence_kit/core/shared_preferences/user_preferences_provider.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/activities/large_card.dart';
import 'package:apparence_kit/modules/activities/providers/filtered_activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(filteredActivitiesProvider);
    final preferences = ref.watch(userPreferencesProvider);
    return Scaffold(
      extendBody: true,
      backgroundColor: context.colors.background,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: ListView(
            children: [
              Text("Discover Activities", style: context.textTheme.headlineLarge),
              Text(
                'Find your perfect activity',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  color: context.colors.onBackground,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              // Show preferences card if set
              if (preferences.hasPreferences)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: ShapeDecoration(
                    shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(24)),
                    color: context.colors.primary.withCustomOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Ionicons.filter_outline, size: 20, color: context.colors.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Active Filters',
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await ref.read(userPreferencesProvider.notifier).clearPreferences();
                              // Refresh activities list
                              ref.invalidate(filteredActivitiesProvider);
                              if (context.mounted) {
                                ref
                                    .read(toastProvider)
                                    .success(title: 'Filters cleared', text: 'Filters cleared');
                              }
                            },
                            child: PressableScale(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: ShapeDecoration(
                                  shape: RoundedSuperellipseBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  color: context.colors.surface,
                                ),
                                child: Text(
                                  'Clear',
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: context.colors.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (preferences.activityType != null && !preferences.surpriseMe)
                            _FilterChip(label: preferences.activityType!, context: context),
                          if (preferences.budgetPerPerson != null)
                            _FilterChip(
                              label: '£${preferences.budgetPerPerson!.toInt()}/person',
                              context: context,
                            ),
                          if (preferences.minPeople != null && preferences.maxPeople != null)
                            _FilterChip(
                              label: '${preferences.minPeople}-${preferences.maxPeople} people',
                              context: context,
                            ),
                          if (preferences.surpriseMe)
                            _FilterChip(label: 'Surprise Me 🎲', context: context),
                        ],
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          context.push('/personalization');
                        },
                        child: Text(
                          'Change preferences',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
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
                                'Answer 3 quick questions for tailored picks',
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

class _FilterChip extends StatelessWidget {
  final String label;
  final BuildContext context;

  const _FilterChip({required this.label, required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(100)),
        color: context.colors.surface,
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colors.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
