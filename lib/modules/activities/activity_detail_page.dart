import 'package:apparence_kit/core/location/providers/user_location_provider.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/modules/activities/entity/activity_entity.dart';
import 'package:apparence_kit/modules/activities/providers/all_activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailPage extends ConsumerWidget {
  final int id;
  const ActivityDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(allActivitiesProvider);
    return Scaffold(
      backgroundColor: context.colors.background,
      body: activitiesAsync.when(
        data: (activities) {
          ActivityEntity? activity;
          for (final ActivityEntity a in activities) {
            if (a.id == id) {
              activity = a;
              break;
            }
          }
          if (activity == null) {
            return Center(child: Text('Activity not found', style: context.textTheme.bodyLarge));
          }

          final double headerHeight = MediaQuery.of(context).size.height * 0.35;
          final String distanceLabel = _computeDistanceLabel(ref, activity.location);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: headerHeight,
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (_isValidImageUrl(activity.imageUrl))
                      Image.network(
                        activity.imageUrl ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: context.colors.primary.withCustomOpacity(0.35));
                        },
                      )
                    else
                      Container(color: context.colors.primary.withCustomOpacity(0.35)),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: context.colors.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  minimum: const EdgeInsets.only(bottom: 16),
                  child: Transform.translate(
                    offset: const Offset(0, 20),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(32)),
                          color: context.colors.surface,
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    activity.name,
                                    style: context.textTheme.headlineSmall,
                                  ),
                                ),
                                if (activity.cost != null)
                                  Text(
                                    '£ ${activity.cost} per person',
                                    style: context.textTheme.titleMedium?.copyWith(
                                      color: context.colors.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                if (activity.minGroupSize != null)
                                  _InfoChip(label: 'Group ${activity.minGroupSize!}+'),
                                if (distanceLabel.isNotEmpty) ...[
                                  const SizedBox(width: 12),
                                  _InfoChip(label: distanceLabel),
                                ],
                              ],
                            ),
                            if (activity.tags.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: activity.tags
                                    .map((tag) => _TagChip(label: tag.name))
                                    .toList(),
                              ),
                            ],
                            const SizedBox(height: 16),
                            if ((activity.description ?? '').isNotEmpty)
                              Text(
                                activity.description!,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colors.onBackground.withValues(alpha: 0.8),
                                  height: 1.5,
                                ),
                              ),
                            const SizedBox(height: 32),
                            if ((activity.website ?? '').isNotEmpty)
                              PressableScale(
                                child: GestureDetector(
                                  onTap: () => _openWebsite(activity!.website!),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 18,
                                    ),
                                    decoration: ShapeDecoration(
                                      shape: RoundedSuperellipseBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      color: context.colors.primary,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Go to website',
                                        style: context.textTheme.titleMedium?.copyWith(
                                          color: context.colors.onPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if ((activity.website ?? '').isNotEmpty) const SizedBox(height: 12),
                            PressableScale(
                              child: GestureDetector(
                                onTap: () => _navigateToCreateEvent(context, activity!),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                                  decoration: ShapeDecoration(
                                    shape: RoundedSuperellipseBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    color: context.colors.primary.withCustomOpacity(0.15),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.event_outlined,
                                        color: context.colors.primary,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Create Event for this Activity',
                                        style: context.textTheme.titleMedium?.copyWith(
                                          color: context.colors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        },
        error: (err, _) => Center(child: Text(err.toString(), style: context.textTheme.bodyLarge)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  String _computeDistanceLabel(WidgetRef ref, String? location) {
    if (location == null || location.isEmpty) {
      return '';
    }
    final List<String> parts = location.split(',');
    if (parts.length != 2) {
      return '';
    }
    final double? lat = double.tryParse(parts[0].trim());
    final double? lng = double.tryParse(parts[1].trim());
    if (lat == null || lng == null) {
      return '';
    }
    final UserLocation userLocation = ref.read(userLocationProvider.notifier);
    userLocation.getUserLocation();
    final double distanceMeters = userLocation.getDistanceTo(lat, lng);
    if (distanceMeters <= 0) {
      return '';
    }
    final String distanceKm = (distanceMeters / 1000).toStringAsFixed(1);
    return '$distanceKm km';
  }

  Future<void> _openWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _navigateToCreateEvent(BuildContext context, ActivityEntity activity) {
    context.push(
      Uri(
        path: '/events/create',
        queryParameters: {'activityId': activity.id.toString(), 'activityName': activity.name},
      ).toString(),
    );
  }

  bool _isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) {
      return false;
    }
    try {
      final Uri uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(100)),
        color: context.colors.primary.withCustomOpacity(0.10),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: context.colors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(100)),
        color: context.colors.onBackground.withCustomOpacity(0.08),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.colors.onBackground.withValues(alpha: 0.7),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
