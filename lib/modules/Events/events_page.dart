import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/modules/Events/event_card.dart';
import 'package:apparence_kit/modules/Events/providers/all_events_provider.dart';
import 'package:apparence_kit/modules/Events/providers/event_participants_by_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EventsPage extends ConsumerWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(allEventsProvider);
    final userState = ref.watch(userStateNotifierProvider);
    final userId = userState.user.idOrNull;
    final gradients = const [
      [Color(0xFFBFA8FF), Color(0xFF6857C9), Color(0xFF4B35F2)],
      [Color(0xFFFF7C7C), Color(0xFFF35252), Color(0xFFE13B3B)],
      [Color(0xFF6AE7FF), Color(0xFF3AC0F2), Color(0xFF1C88E5)],
    ];
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            Text('Events', style: context.textTheme.headlineLarge),
            const SizedBox(height: 12),
            SizedBox(
              height: 420,
              child: eventsAsync.when(
                data: (events) {
                  if (events.isEmpty) {
                    return Center(
                      child: Text(
                        'No events yet',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onBackground.withValues(alpha: 0.6),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      final participantsAsync = ref.watch(
                        eventParticipantsByEventProvider(eventId: event.id),
                      );
                      final participantsInitials = participantsAsync.maybeWhen(
                        data: (list) => list
                            .map((p) => p.userId.substring(0, 2).toUpperCase())
                            .toList(),
                        orElse: () => const <String>[],
                      );
                      final isGoing = participantsAsync.maybeWhen(
                        data: (list) => userId != null && list.any((p) => p.userId == userId),
                        orElse: () => false,
                      );
                      final statusLabel = isGoing ? 'Going' : 'Invited';
                      final gradientColors = gradients[index % gradients.length];
                      final dateStr = event.date != null
                          ? DateFormat('EEE, d MMMM, h:mma').format(event.date!.toLocal())
                          : 'Date TBD';
                      final location = event.location ?? 'Unknown';
                      return EventCard(
                        title: event.title,
                        date: dateStr,
                        location: location,
                        statusLabel: statusLabel,
                        gradientColors: gradientColors,
                        participants: participantsInitials,
                      );
                    },
                    separatorBuilder: (context, _) => const SizedBox(width: 16),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(
                  child: Text(
                    'Failed to load events',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onBackground.withValues(alpha: 0.6),
                    ),
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}
