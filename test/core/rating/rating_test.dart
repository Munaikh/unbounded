import 'package:apparence_kit/core/rating/models/rating.dart';
import 'package:flutter_test/flutter_test.dart';

import 'rating_api_fake.dart';

void main() {
  test(
    'user has installed the app 4 days ago, never answered => shouldAsk returns true ',
    () {
      final rating = Rating(
        settings: RatingSettings(
          delayBeforeAsking: const Duration(days: 3),
          delayBeforeAskingAgain: const Duration(days: 7),
        ),
        ratingApi: RatingApiFake(),
        current: DateTime.now(),
        lastAskingDate: null,
        userCreationDate: DateTime.now().subtract(const Duration(days: 4)),
        hasRateApp: false,
      );
      expect(rating.shouldAsk(), isTrue);
    },
  );

  test(
    'user has installed the app 200 days ago, reviewed => shouldAsk should return false ',
    () {
      final rating = Rating(
        settings: RatingSettings(
          delayBeforeAsking: const Duration(days: 3),
          delayBeforeAskingAgain: const Duration(days: 7),
        ),
        ratingApi: RatingApiFake(),
        current: DateTime.now(),
        lastAskingDate: null,
        userCreationDate: DateTime.now().subtract(const Duration(days: 200)),
        hasRateApp: true,
      );
      expect(rating.shouldAsk(), isFalse);
    },
  );

  test(
    'user has delayed 10 days ago, delayBeforeAskingAgain = 7 days => shouldAsk should return true ',
    () {
      final rating = Rating(
        settings: RatingSettings(
          delayBeforeAsking: const Duration(days: 3),
          delayBeforeAskingAgain: const Duration(days: 7),
        ),
        ratingApi: RatingApiFake(),
        current: DateTime.now(),
        lastAskingDate: DateTime.now().subtract(const Duration(days: 10)),
        userCreationDate: DateTime.now().subtract(const Duration(days: 200)),
        hasRateApp: true,
      );
      expect(rating.shouldAsk(), isFalse);
    },
  );
}
