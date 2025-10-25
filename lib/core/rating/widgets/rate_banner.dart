import 'package:apparence_kit/core/rating/models/rating.dart';
import 'package:apparence_kit/core/rating/providers/rating_repository.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnRateBannerCallback = void Function();

/// This widget will display a banner to ask the user to review and rate the app
/// on Apple Store or Play Store
/// This is one of the most important things to do to improve your app visibility
/// Tip : Ask for a review after a positive action from the user and not at the first launch
///
/// - It will be displayed only if the user is authenticated and if he has not
/// already rate the app
/// - It will be displayed only if the user has installed the app since a certain
/// amount of time
/// - It will be displayed only if the user has declined to rate the app since a
/// certain amount of time
/// You can customize this widget as you want
class RateBanner extends ConsumerStatefulWidget {
  /// The delay before asking the user to rate the app after he installed it
  final Duration? delayBeforeAsking;

  /// The delay before asking again if the user has declined
  final Duration? delayBeforeAskingAgain;

  /// The title of the banner (default: "We need your help!")
  final String title;

  /// The text of the banner (default: "Do you have a minute to leave us a review on the store?")
  final String text;

  /// The text of the button to rate the app (default: "Yes sure!")
  final String rateButtonText;

  /// The text of the button to decline the rating (default: "Later...")
  final String laterButtonText;

  /// If true and in debug mode, the banner will be displayed not matter what
  final bool forceInDebug;

  const RateBanner({
    super.key,
    this.delayBeforeAsking,
    this.delayBeforeAskingAgain,
    this.title = "Do you like our app?",
    this.text = "Do you have a minute to leave us a review on the store?",
    this.rateButtonText = "Yes sure!",
    this.laterButtonText = "Later...",
    this.forceInDebug = false,
  });

  // TODO create factory that get value from env

  @override
  ConsumerState<RateBanner> createState() => _RateBannerState();
}

class _RateBannerState extends ConsumerState<RateBanner> {
  bool _shouldShowDebug = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ratingRepository = ref.watch(ratingRepositoryProvider);
    final userState = ref.watch(userStateNotifierProvider);
    final ratingFuture = ratingRepository.get(userState.user);
    return FutureBuilder<Rating>(
        future: ratingFuture,
        builder: (context, snapshot) {
          final shouldAsk = snapshot.hasData && snapshot.data!.shouldAsk();
          final shouldForce =
              widget.forceInDebug && kDebugMode && _shouldShowDebug;

          if (!shouldAsk && !shouldForce) {
            return const SizedBox();
          }
          return RateBannerWidget(
            title: widget.title,
            text: widget.text,
            rateButtonText: widget.rateButtonText,
            laterButtonText: widget.laterButtonText,
            onAccept: () async {
              await ratingRepository.rate();
              await snapshot.data!.openStoreListing();
              setState(() {
                _shouldShowDebug = false;
              });
            },
            onDecline: () async {
              await ratingRepository.delay();
              setState(() {
                _shouldShowDebug = false;
              });
            },
          );
        });
  }
}

class RateBannerWidget extends StatelessWidget {
  final String title;
  final String text;
  final String rateButtonText;
  final String laterButtonText;
  final OnRateBannerCallback onAccept;
  final OnRateBannerCallback onDecline;

  const RateBannerWidget({
    super.key,
    required this.onAccept,
    required this.onDecline,
    required this.title,
    required this.text,
    required this.rateButtonText,
    required this.laterButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      color: Theme.of(context).primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RateBannerButton(
                key: const ValueKey('later_button'),
                text: laterButtonText,
                onTap: onDecline,
              ),
              RateBannerButton(
                key: const ValueKey('positive_button'),
                text: rateButtonText,
                onTap: onAccept,
                hasBorder: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RateBannerButton extends StatelessWidget {
  final String text;
  final OnRateBannerCallback? onTap;
  final bool hasBorder;

  const RateBannerButton({
    super.key,
    required this.text,
    this.onTap,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: hasBorder
            ? const EdgeInsets.symmetric(vertical: 6, horizontal: 8)
            : const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: hasBorder
              ? Border.all(
                  color: Colors.white,
                )
              : null,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
