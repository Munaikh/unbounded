import 'package:apparence_kit/core/rating/providers/rating_repository.dart';
import 'package:apparence_kit/core/states/user_state_notifier.dart';
import 'package:apparence_kit/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

void showRatingPopup(WidgetRef ref) {
  final ratingRepository = ref.watch(ratingRepositoryProvider);
  final userState = ref.watch(userStateNotifierProvider);
  final ratingFuture = ratingRepository.get(userState.user);

  ratingFuture.then((rating) {
    final shouldAsk = rating.shouldAsk();
    Logger().d('should Ask for rating: $shouldAsk');
    if (shouldAsk && ref.context.mounted) {
      showDialog(
        context: ref.context,
        builder: (context) {
          ratingRepository.delay();
          return AlertDialog.adaptive(
            title: Text(Translations.of(context).rate_popup.title),
            
            content: Text(Translations.of(context).rate_popup.description),
            
            actions: <Widget>[
              TextButton(
                child: Text(Translations.of(context).rate_popup.cancel_button),
                
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(Translations.of(context).rate_popup.rate_button),
                
                onPressed: () async {
                  Navigator.of(context).pop();
                  await ratingRepository.rate();
                  await rating.showRatingDialog();
                },
              ),
            ],
          );
        },
      );
    }
  });
}
