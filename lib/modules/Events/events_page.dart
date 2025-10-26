import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/modules/events/event_card.dart';
import 'package:apparence_kit/modules/events/providers/all_events_provider.dart';
import 'package:apparence_kit/modules/events/providers/event_attendees_provider.dart';
import 'package:apparence_kit/modules/events/providers/user_joined_events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EventsPage extends ConsumerWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(allEventsProvider);
    final joinedEventsAsync = ref.watch(userJoinedEventsProvider);
    final userState = ref.watch(userStateNotifierProvider);
    final currentUserName = userState.user.when(
      authenticated:
          (
            email,
            name,
            id,
            creationDate,
            lastUpdateDate,
            avatarPath,
            onboarded,
            subscription,
          ) => name,
      anonymous: (id, onboarded, subscription, creationDate, lastUpdateDate) =>
          null,
      loading: () => null,
    );
    final Set<String> joinedIds = joinedEventsAsync.maybeWhen(
      data: (events) => events.map((e) => e.id).toSet(),
      orElse: () => <String>{},
    );
    
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            Text('Events', style: context.textTheme.headlineLarge),
            const SizedBox(height: 12),
            
            // My Events Section
            joinedEventsAsync.when(
              data: (joinedEvents) {
                if (joinedEvents.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Events',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 420,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: joinedEvents.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final e = joinedEvents[index];
                          final displayDate = e.date != null
                              ? '${e.date!.toLocal()}'
                              : '';
                          final attendeesAsync = ref.watch(
                            eventAttendeesProvider(e.id),
                          );
                          final participants = attendeesAsync.maybeWhen(
                            data: (users) => users
                                .map((u) => _initialsFromName(u.name ?? ''))
                                .take(3)
                                .toList(),
                            orElse: () => const <String>[],
                          );
                          return EventCard(
                            title: e.title,
                            description: e.description,
                            date: displayDate,
                            location: e.location ?? '',
                            statusLabel: 'Joined',
                            gradientColors: const [
                              Color(0xFF6DD5FA),
                              Color(0xFF2980B9),
                              Color(0xFF1E3C72),
                            ],
                            participants: participants.isEmpty
                                ? const ['AA', 'MA', 'KH']
                                : participants,
                            backgroundImageUrl: e.bgUrl,
                            creatorName: currentUserName,
                            onTap: () => context.push('/events/${e.id}'),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'All Events',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              },
              error: (_, __) => const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
            ),

            // All Events Section
            eventsAsync.when(
              data: (events) {
                if (events.isEmpty) {
                  return const SizedBox.shrink();
                }
                return SizedBox(
                  height: 420,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: events.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final e = events[index];
                      final displayDate = e.date != null
                          ? '${e.date!.toLocal()}'
                          : '';
                      final bool isJoined = joinedIds.contains(e.id);
                      final attendeesAsync = ref.watch(
                        eventAttendeesProvider(e.id),
                      );
                      final participants = attendeesAsync.maybeWhen(
                        data: (users) => users
                            .map((u) => _initialsFromName(u.name ?? ''))
                            .take(3)
                            .toList(),
                        orElse: () => const <String>[],
                      );
                      return EventCard(
                        title: e.title,
                        description: e.description,
                        date: displayDate,
                        location: e.location ?? '',
                        statusLabel: isJoined ? 'Joined' : 'Invited',
                        gradientColors: const [
                          Color(0xFFBFA8FF),
                          Color(0xFF6857C9),
                          Color(0xFF4B35F2),
                        ],
                        participants: participants.isEmpty
                            ? const ['AA', 'MA', 'KH']
                            : participants,
                        backgroundImageUrl: e.bgUrl,
                        creatorName: currentUserName,
                        onTap: () => context.push('/events/${e.id}'),
                      );
                    },
                  ),
                );
              },
              error: (err, _) => Text('$err'),
              loading: () => const SizedBox(
                height: 420,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 32),
            
            Text(
              'Start an event, get\neveryone on board',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.colors.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Takes 30 seconds. You can edit details or cancel\nanytime.',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w300,
                color: context.colors.onBackground.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            PressableScale(
              child: GestureDetector(
                onTap: () => context.push('/events/create'),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 60,
                  decoration: ShapeDecoration(
                    shape: RoundedSuperellipseBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    color: context.colors.primary,
                    shadows: [
                      BoxShadow(
                        color: context.colors.shadow.withCustomOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Create an event',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colors.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _initialsFromName(String name) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return '🙂';
  final parts = trimmed.split(RegExp(r'\s+'));
  if (parts.length == 1) {
    return parts.first.substring(0, 1).toUpperCase();
  }
  final String first = parts.first.substring(0, 1).toUpperCase();
  final String last = parts.last.substring(0, 1).toUpperCase();
  return '$first$last';
}
