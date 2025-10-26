import 'dart:ui';

import 'package:apparence_kit/core/data/api/user_api.dart';
import 'package:apparence_kit/core/data/entities/user_entity.dart';
import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/core/theme/extensions/theme_extension.dart';
import 'package:apparence_kit/core/widgets/buttons/pressable_scale.dart';
import 'package:apparence_kit/core/widgets/toast.dart';
import 'package:apparence_kit/modules/events/api/event_participants_api.dart';
import 'package:apparence_kit/modules/events/api/events_api.dart';
import 'package:apparence_kit/modules/events/providers/event_activity_provider.dart';
import 'package:apparence_kit/modules/events/providers/event_attendees_provider.dart';
import 'package:apparence_kit/modules/events/providers/user_joined_events_provider.dart';
import 'package:apparence_kit/modules/events/ui/widgets/name_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      final isJoined = await participantsApi.isUserJoined(eventId: widget.eventId, userId: userId);
      if (mounted) {
        setState(() => _isJoined = isJoined);
      }
    } catch (_) {}
  }

  Future<void> _toggleJoinEvent() async {
    final userState = ref.read(userStateNotifierProvider);
    final user = userState.user;

    // Check if user has a name when trying to join
    if (!_isJoined) {
      String? userName;
      if (user case AuthenticatedUserData(:final name)) {
        userName = name;
      }

      // If name not in current state (e.g., anonymous user variant), read from DB
      if (userName == null || userName.trim().isEmpty) {
        try {
          final current = await ref.read(userApiProvider).get(user.idOrThrow);
          final dbName = current?.name;
          if (dbName != null && dbName.trim().isNotEmpty) {
            userName = dbName;
          }
        } catch (_) {}
      }

      if (userName == null || userName.trim().isEmpty) {
        // Show name input dialog
        final String? enteredName = await showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (context) => const NameInputDialog(),
        );

        if (enteredName == null) {
          // User cancelled
          return;
        }

        // Update user name in database
        try {
          final userApi = ref.read(userApiProvider);
          final userId = user.idOrThrow;
          await userApi.update(UserEntity(id: userId, name: enteredName));
          // Refresh user state
          await ref.read(userStateNotifierProvider.notifier).refresh();
        } catch (e) {
          if (mounted) {
            ref.read(toastProvider).error(title: 'Error', text: 'Failed to update name: $e');
          }
          return;
        }
      }
    }

    setState(() => _isProcessing = true);
    try {
      final userId = user.idOrThrow;
      final participantsApi = ref.read(eventParticipantsApiProvider);
      if (_isJoined) {
        await participantsApi.leaveEvent(eventId: widget.eventId, userId: userId);
        if (mounted) {
          ref.read(toastProvider).success(title: 'Left Event', text: 'You have left the event');
          setState(() => _isJoined = false);
          ref.invalidate(userJoinedEventsProvider);
          ref.invalidate(eventAttendeesProvider(widget.eventId));
        }
      } else {
        await participantsApi.joinEvent(eventId: widget.eventId, userId: userId);
        if (mounted) {
          ref.read(toastProvider).success(title: 'Joined Event', text: 'You have joined the event');
          setState(() => _isJoined = true);
          ref.invalidate(userJoinedEventsProvider);
          ref.invalidate(eventAttendeesProvider(widget.eventId));
        }
      }
    } catch (e) {
      if (mounted) {
        ref
            .read(toastProvider)
            .error(title: 'Error', text: 'Failed to ${_isJoined ? 'leave' : 'join'} event: $e');
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  String _getInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'E';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    final String first = parts.first.substring(0, 1).toUpperCase();
    final String last = parts.last.substring(0, 1).toUpperCase();
    return '$first$last';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(eventsApiProvider).getEventDetails(widget.eventId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        }

        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: Text('Event not found')));
        }

        final event = snapshot.data!;

        return Scaffold(
          body: Stack(
            children: [
              // Full-page background
              Positioned.fill(
                child: event.bgUrl != null && event.bgUrl!.isNotEmpty
                    ? Image.network(
                        event.bgUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFBFA8FF), Color(0xFF6857C9), Color(0xFF4B35F2)],
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFFBFA8FF), Color(0xFF6857C9), Color(0xFF4B35F2)],
                          ),
                        ),
                      ),
              ),
              // Dark overlay for better readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              SafeArea(
                child: Column(
                  children: [
                    // Header with back button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            // Creator avatar with glassmorphism
                            FutureBuilder<UserEntity?>(
                              future: ref.read(userApiProvider).get(event.owner),
                              builder: (context, userSnapshot) {
                                final creatorName = userSnapshot.data?.name ?? 'Event';
                                return ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white.withValues(alpha: 0.4),
                                            Colors.white.withValues(alpha: 0.2),
                                          ],
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: 0.3),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.2),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          _getInitials(creatorName),
                                          style: context.textTheme.displaySmall?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black.withValues(alpha: 0.3),
                                                offset: const Offset(0, 2),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 32),
                            // Event title with glassmorphism
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withValues(alpha: 0.25),
                                        Colors.white.withValues(alpha: 0.15),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: context.textTheme.headlineMedium?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withValues(alpha: 0.3),
                                              offset: const Offset(0, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Date and location chips
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children: [
                                          if (event.date != null)
                                            _GlassInfoChip(
                                              icon: Icons.calendar_today_rounded,
                                              label: _formatEventDate(event.date!),
                                            ),
                                          if (event.location != null && event.location!.isNotEmpty)
                                            _GlassInfoChip(
                                              icon: Icons.location_on_rounded,
                                              label: event.location!,
                                            ),
                                        ],
                                      ),
                                      if (event.description.isNotEmpty) ...[
                                        const SizedBox(height: 20),
                                        Text(
                                          event.description,
                                          style: context.textTheme.bodyLarge?.copyWith(
                                            color: Colors.white.withValues(alpha: 0.95),
                                            height: 1.6,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black.withValues(alpha: 0.2),
                                                offset: const Offset(0, 1),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Linked Activity section with glassmorphism
                            if (event.activityId != null)
                              Consumer(
                                builder: (context, ref, _) {
                                  final activityAsync = ref.watch(
                                    eventActivityProvider(event.activityId!),
                                  );
                                  return activityAsync.when(
                                    data: (activity) {
                                      if (activity == null) {
                                        return const SizedBox.shrink();
                                      }
                                      return Column(
                                        children: [
                                          PressableScale(
                                            child: GestureDetector(
                                              onTap: () {
                                                context.push('/activities/${activity.id}');
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(24),
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets.all(24),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topLeft,
                                                        end: Alignment.bottomRight,
                                                        colors: [
                                                          Colors.white.withValues(alpha: 0.25),
                                                          Colors.white.withValues(alpha: 0.15),
                                                        ],
                                                      ),
                                                      borderRadius: BorderRadius.circular(24),
                                                      border: Border.all(
                                                        color: Colors.white.withValues(alpha: 0.3),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        if (activity.imageUrl != null &&
                                                            activity.imageUrl!.isNotEmpty)
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(16),
                                                            child: Image.network(
                                                              activity.imageUrl!,
                                                              width: 80,
                                                              height: 80,
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context, error, stackTrace) {
                                                                    return Container(
                                                                      width: 80,
                                                                      height: 80,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white
                                                                            .withValues(alpha: 0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              16,
                                                                            ),
                                                                      ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .local_activity_rounded,
                                                                        color: Colors.white
                                                                            .withValues(alpha: 0.7),
                                                                        size: 36,
                                                                      ),
                                                                    );
                                                                  },
                                                            ),
                                                          )
                                                        else
                                                          Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white.withValues(
                                                                alpha: 0.2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(
                                                                16,
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              Icons.local_activity_rounded,
                                                              color: Colors.white.withValues(
                                                                alpha: 0.7,
                                                              ),
                                                              size: 36,
                                                            ),
                                                          ),
                                                        const SizedBox(width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Linked Activity',
                                                                style: context.textTheme.bodySmall
                                                                    ?.copyWith(
                                                                      color: Colors.white
                                                                          .withValues(alpha: 0.8),
                                                                      fontWeight: FontWeight.w500,
                                                                      letterSpacing: 0.5,
                                                                      shadows: [
                                                                        Shadow(
                                                                          color: Colors.black
                                                                              .withValues(
                                                                                alpha: 0.3,
                                                                              ),
                                                                          offset: const Offset(
                                                                            0,
                                                                            1,
                                                                          ),
                                                                          blurRadius: 2,
                                                                        ),
                                                                      ],
                                                                    ),
                                                              ),
                                                              const SizedBox(height: 6),
                                                              Text(
                                                                activity.name,
                                                                style: context.textTheme.titleMedium
                                                                    ?.copyWith(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.w700,
                                                                      shadows: [
                                                                        Shadow(
                                                                          color: Colors.black
                                                                              .withValues(
                                                                                alpha: 0.3,
                                                                              ),
                                                                          offset: const Offset(
                                                                            0,
                                                                            2,
                                                                          ),
                                                                          blurRadius: 4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                              ),
                                                              if (activity.description != null &&
                                                                  activity
                                                                      .description!
                                                                      .isNotEmpty) ...[
                                                                const SizedBox(height: 4),
                                                                Text(
                                                                  activity.description!,
                                                                  style: context.textTheme.bodySmall
                                                                      ?.copyWith(
                                                                        color: Colors.white
                                                                            .withValues(alpha: 0.7),
                                                                        height: 1.4,
                                                                        shadows: [
                                                                          Shadow(
                                                                            color: Colors.black
                                                                                .withValues(
                                                                                  alpha: 0.2,
                                                                                ),
                                                                            offset: const Offset(
                                                                              0,
                                                                              1,
                                                                            ),
                                                                            blurRadius: 2,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ],
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Icon(
                                                          Icons.arrow_forward_ios_rounded,
                                                          color: Colors.white.withValues(
                                                            alpha: 0.8,
                                                          ),
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                        ],
                                      );
                                    },
                                    loading: () => const SizedBox.shrink(),
                                    error: (e, _) => const SizedBox.shrink(),
                                  );
                                },
                              ),
                            // Participants section with glassmorphism
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withValues(alpha: 0.25),
                                        Colors.white.withValues(alpha: 0.15),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Participants',
                                        style: context.textTheme.titleLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withValues(alpha: 0.3),
                                              offset: const Offset(0, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Consumer(
                                        builder: (context, ref, _) {
                                          final attendeesAsync = ref.watch(
                                            eventAttendeesProvider(widget.eventId),
                                          );
                                          return attendeesAsync.when(
                                            data: (users) {
                                              if (users.isEmpty) {
                                                return Text(
                                                  'No participants yet',
                                                  style: context.textTheme.bodyMedium?.copyWith(
                                                    color: Colors.white.withValues(alpha: 0.7),
                                                  ),
                                                );
                                              }
                                              return Wrap(
                                                spacing: 12,
                                                runSpacing: 12,
                                                children: [
                                                  for (final u in users)
                                                    ClipOval(
                                                      child: BackdropFilter(
                                                        filter: ImageFilter.blur(
                                                          sigmaX: 8,
                                                          sigmaY: 8,
                                                        ),
                                                        child: Container(
                                                          width: 48,
                                                          height: 48,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            gradient: LinearGradient(
                                                              begin: Alignment.topLeft,
                                                              end: Alignment.bottomRight,
                                                              colors: [
                                                                Colors.white.withValues(alpha: 0.3),
                                                                Colors.white.withValues(
                                                                  alpha: 0.15,
                                                                ),
                                                              ],
                                                            ),
                                                            border: Border.all(
                                                              color: Colors.white.withValues(
                                                                alpha: 0.4,
                                                              ),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              _initialsFromName(u.name ?? ''),
                                                              style: context.textTheme.bodyMedium
                                                                  ?.copyWith(
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.w600,
                                                                    shadows: [
                                                                      Shadow(
                                                                        color: Colors.black
                                                                            .withValues(alpha: 0.3),
                                                                        offset: const Offset(0, 1),
                                                                        blurRadius: 2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            },
                                            loading: () => const SizedBox(
                                              height: 48,
                                              child: Center(
                                                child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            error: (e, _) => Text(
                                              'Failed to load participants',
                                              style: context.textTheme.bodyMedium?.copyWith(
                                                color: Colors.white.withValues(alpha: 0.7),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Join/Leave button with glassmorphism
                            PressableScale(
                              child: GestureDetector(
                                onTap: _isProcessing ? null : _toggleJoinEvent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                        vertical: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: _isProcessing
                                              ? [
                                                  Colors.white.withValues(alpha: 0.2),
                                                  Colors.white.withValues(alpha: 0.1),
                                                ]
                                              : _isJoined
                                              ? [
                                                  const Color(0xFFFF6B6B).withValues(alpha: 0.8),
                                                  const Color(0xFFEE5A6F).withValues(alpha: 0.7),
                                                ]
                                              : [
                                                  Colors.white.withValues(alpha: 0.35),
                                                  Colors.white.withValues(alpha: 0.25),
                                                ],
                                        ),
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: 0.4),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.2),
                                            blurRadius: 16,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: _isProcessing
                                            ? const SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.5,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                _isJoined ? 'Leave Event' : 'Join Event',
                                                style: context.textTheme.titleMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 17,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black.withValues(alpha: 0.3),
                                                      offset: const Offset(0, 1),
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

class _GlassInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _GlassInfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white.withValues(alpha: 0.3), Colors.white.withValues(alpha: 0.2)],
            ),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
