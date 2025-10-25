import 'package:apparence_kit/core/data/models/user.dart';
import 'package:apparence_kit/core/rating/api/rating_api.dart';
import 'package:apparence_kit/core/rating/models/rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingRepositoryProvider = Provider<RatingRepository>(
  (ref) => RatingRepository(
    ratingApi: ref.watch(ratingApiProvider),
  ),
);

class RatingRepository {
  final RatingApi _ratingApi;

  RatingRepository({
    required RatingApi ratingApi,
  }) : _ratingApi = ratingApi;

  Future<Rating> get(User user) async {
    final lastAskingDate = await _ratingApi.lastAskingDate();
    final hasRateApp = await _ratingApi.hasRateApp();
    final creationDate = switch(user) {
      AuthenticatedUserData(:final creationDate) => creationDate,
      AnonymousUserData(:final creationDate) => creationDate,
      _ => null,
    };
    return Rating(
      ratingApi: _ratingApi,
      settings: RatingSettings(
        delayBeforeAsking: const Duration(days: 3), // TODO get from env
        delayBeforeAskingAgain: const Duration(days: 7), // TODO get from env
      ),
      lastAskingDate: lastAskingDate,
      userCreationDate: creationDate,
      hasRateApp: hasRateApp,
    );
  }

  /// we will delay the next asking date according to the settings
  Future<void> delay() async {
    await _ratingApi.saveLastAskingDate();
  }

  // we don't really knows if user actually left a comment and rate our app
  // so we will consider that he did it
  // (it's because Apple and google don't want us to know if user rate our app)
  Future<void> rate() async {
    await _ratingApi.saveHasRateApp();
  }
}
