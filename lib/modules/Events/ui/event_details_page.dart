import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/core/theme/colors.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/events/api/event_participants_api.dart';
import 'package:apparence_kit/modules/events/api/events_api.dart';
import 'package:apparence_kit/modules/events/providers/user_joined_events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends ConsumerStatefulWidget {
  final String eventId;

  const EventDetailsPage({super.key, required this.eventId});

  @override
  ConsumerState<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends ConsumerState<EventDetailsPage> {
  bool _isJoined = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _checkIfJoined();
  }

  Future<void> _checkIfJoined() async {
    try {
      final userState = ref.read(userStateNotifierProvider);
      final userId = userState.user.idOrThrow;
      final participantsApi = ref.read(eventParticipantsApiProvider);
      final isJoined = await participantsApi.isUserJoined(
        eventId: widget.eventId,
        userId: userId,
      );
      if (mounted) {
        setState(() => _isJoined = isJoined);
      }
    } catch (_) {}
  }

  Future<void> _toggleJoinEvent() async {
    setState(() => _isProcessing = true);
    try {
      final userState = ref.read(userStateNotifierProvider);
      final userId = userState.user.idOrThrow;
      final participantsApi = ref.read(eventParticipantsApiProvider);
      if (_isJoined) {
        await participantsApi.leaveEvent(
          eventId: widget.eventId,
          userId: userId,
        );
        if (mounted) {
          ref
              .read(toastProvider)
              .success(title: 'Left Event', text: 'You have left the event');
          setState(() => _isJoined = false);
          ref.invalidate(userJoinedEventsProvider);
        }
      } else {
        await participantsApi.joinEvent(
          eventId: widget.eventId,
          userId: userId,
        );
        if (mounted) {
          ref
              .read(toastProvider)
              .success(
                title: 'Joined Event',
                text: 'You have joined the event',
              );
          setState(() => _isJoined = true);
          ref.invalidate(userJoinedEventsProvider);
        }
      }
    } catch (e) {
      if (mounted) {
        ref
            .read(toastProvider)
            .error(
              title: 'Error',
              text: 'Failed to ${_isJoined ? 'leave' : 'join'} event: $e',
            );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: FutureBuilder(
        future: ref.read(eventsApiProvider).getEventDetails(widget.eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Event not found'));
          }

          final event = snapshot.data!;
          final double headerHeight = MediaQuery.of(context).size.height * 0.35;

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
                    if (event.bgUrl != null && event.bgUrl!.isNotEmpty)
                      Image.network(
                        event.bgUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFBFA8FF),
                                  Color(0xFF6857C9),
                                  Color(0xFF4B35F2),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFBFA8FF),
                              Color(0xFF6857C9),
                              Color(0xFF4B35F2),
                            ],
                          ),
                        ),
                      ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: context.colors.shadow.withCustomOpacity(
                                0.10,
                              ),
                              blurRadius: 16,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white.withCustomOpacity(.3),
                          child: Text(
                            'KH',
                            style: context.textTheme.displaySmall?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
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
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
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
                                    event.title,
                                    style: context.textTheme.headlineSmall,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                if (event.date != null)
                                  _InfoChip(
                                    label: _formatEventDate(event.date!),
                                  ),
                                if (event.location != null &&
                                    event.location!.isNotEmpty) ...[
                                  const SizedBox(width: 12),
                                  _InfoChip(label: event.location!),
                                ],
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (event.description.isNotEmpty)
                              Text(
                                event.description,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colors.onBackground.withValues(
                                    alpha: 0.8,
                                  ),
                                  height: 1.5,
                                ),
                              ),
                            const SizedBox(height: 32),
                            Text(
                              'Participants',
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                for (final initial in ['AA', 'MA', 'KH'])
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: context.colors.primary
                                          .withCustomOpacity(0.15),
                                      child: Text(
                                        initial,
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: context.colors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            PressableScale(
                              child: GestureDetector(
                                onTap: _isProcessing ? null : _toggleJoinEvent,
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
                                    color: _isProcessing
                                        ? context.colors.primary
                                              .withCustomOpacity(0.6)
                                        : _isJoined
                                        ? context.colors.error
                                        : context.colors.primary,
                                  ),
                                  child: Center(
                                    child: _isProcessing
                                        ? SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    context.colors.onPrimary,
                                                  ),
                                            ),
                                          )
                                        : Text(
                                            _isJoined
                                                ? 'Leave Event'
                                                : 'Join Event',
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                  color:
                                                      context.colors.onPrimary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
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
      ),
    );
  }

  String _formatEventDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Tomorrow ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE HH:mm').format(date);
    } else {
      return DateFormat('MMM d, HH:mm').format(date);
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
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(100),
        ),
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
