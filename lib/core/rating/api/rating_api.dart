// coverage:ignore-file to ignore the whole file.
import 'package:apparence_kit/core/shared_preferences/shared_preferences.dart';
import 'package:apparence_kit/environnements.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _lastAskKey = 'last_asking_date';
const _hasRateAppKey = 'has_rate_app';

final ratingApiProvider = Provider<RatingApi>((ref) {
  final prefsBuilder = ref.watch(sharedPreferencesProvider);
  return RatingApi(
    prefs: prefsBuilder.prefs,
    inAppReview: InAppReview.instance,
    env: ref.watch(environmentProvider),
  );
});

/// we choosed here to save the last asking date and if the user has rate the app
/// in the shared preferences
/// But you can use any other storage solution (also in your remote database)
class RatingApi {
  final SharedPreferences _prefs;
  final InAppReview _inAppReview;
  final Environment _env;

  RatingApi({
    required SharedPreferences prefs,
    required InAppReview inAppReview,
    required Environment env,
  })  : _prefs = prefs,
        _env = env,
        _inAppReview = inAppReview;

  Future<void> saveLastAskingDate() async {
    final now = DateTime.now();
    await _prefs.setInt(_lastAskKey, now.millisecondsSinceEpoch);
  }

  Future<void> saveHasRateApp() async {
    await _prefs.setBool(_hasRateAppKey, true);
  }

  void reset() {
    _prefs.remove(_lastAskKey);
    _prefs.remove(_hasRateAppKey);
  }

  Future<bool> hasRateApp() async {
    final hasRateApp = _prefs.getBool(_hasRateAppKey);
    return hasRateApp ?? false;
  }

  Future<DateTime?> lastAskingDate() async {
    final lastAskingDate = _prefs.getInt(_lastAskKey);
    if (lastAskingDate == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(lastAskingDate);
  }

  Future<void> openStoreListing() {
    if (_env.appStoreId == null) {
      throw Exception(
        '''appStoreId is not defined in your environment, check [environnements.dart] file''',
      );
    }
    return _inAppReview.openStoreListing(appStoreId: _env.appStoreId);
  }

  Future<void> showRatingDialog() {
    return _inAppReview.requestReview();
  }
}
