import 'package:apparence_kit/core/rating/api/rating_api.dart';

class RatingSettings {
  final Duration delayBeforeAsking;
  final Duration delayBeforeAskingAgain;

  RatingSettings({
    required this.delayBeforeAsking,
    required this.delayBeforeAskingAgain,
  });
}

class Rating {
  final RatingApi _ratingApi;
  final RatingSettings settings;
  final DateTime? lastAskingDate;
  final DateTime? userCreationDate;
  final DateTime _current;
  final bool hasRateApp;

  Rating({
    required this.settings,
    required RatingApi ratingApi,
    required this.lastAskingDate,
    required this.userCreationDate,
    required this.hasRateApp,
    DateTime? current,
  })  : _ratingApi = ratingApi,
        _current = current ?? DateTime.now();

  bool shouldAsk() {
    if (userCreationDate == null) {
      return false;
    }
    if (hasRateApp) {
      return false;
    }
    final appInstallDiff = _current.difference(userCreationDate!);
    if (appInstallDiff < settings.delayBeforeAsking) {
      return false;
    }
    if (lastAskingDate == null) {
      return true;
    }
    return lastAskingDate!.difference(_current) >
        settings.delayBeforeAskingAgain;
  }

  Future<void> openStoreListing() => _ratingApi.openStoreListing();

  Future<void> showRatingDialog() => _ratingApi.showRatingDialog();
}
