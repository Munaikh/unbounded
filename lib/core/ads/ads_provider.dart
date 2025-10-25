// ignore_for_file: unused_element, unused_element_parameter

import 'package:apparence_kit/core/ads/ads_state.dart';
import 'package:apparence_kit/environnements.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_io/io.dart';

part 'ads_provider.g.dart';

typedef OnAdsCallback = void Function();

/// ---------------------------------
/// ⚠ You first need to publish your app on the Play Store or App Store
/// then you will be able to get your ad unit ids.
/// publish a first version of your app without ads to get your app approved
/// then you will be able to add ads to your app.
/// see the guide on the ApparenceKit documentation
/// ---------------------------------

@Riverpod(keepAlive: true)
class GoogleAdsNotifier extends _$GoogleAdsNotifier {
  // ---------------------------------
  // 👇 uncomment this to enable ads
  // Please see the pre requisites in the [ads guide](./docs/ad_mobs.md)
  // ---------------------------------

  // InterstitialAd? current;

  final Logger logger = Logger();

  Environment get environment => ref.read(environmentProvider);

  @override
  AdState build() {
    return const AdState();
  }

  /// shows an ad if the elapsed time since the last ad is greater than [secondsSinceLastAds]
  /// if [secondsSinceLastAds] is null, it will default to 50 seconds
  Future<void> showIfElapsedTime({
    int? secondsSinceLastAds,
    OnAdsCallback? onShow,
    OnAdsCallback? onDismissed,
    OnAdsCallback? onFailed,
  }) {
    if (state.lastAdShown == null ||
        state.timeSinceLastAd.inSeconds > (secondsSinceLastAds ?? 50)) {
      return show(onDismissed: onDismissed, onFailed: onFailed, onShow: onShow);
    }
    return Future.value();
  }

  /// directly shows an ad
  Future<void> show({
    OnAdsCallback? onShow,
    OnAdsCallback? onDismissed,
    OnAdsCallback? onFailed,
  }) async {
    // You can create an adFree mode for your premium members for ex...
    // if (isAdFree) {
    //   debugPrint("🤖 - No ads mode");
    //   return;
    // }
    String adUnitId = '';
    if (Platform.isAndroid && environment.androidInterstitialAdUnitId != null) {
      logger.i("👉 - testing interstitial ads");
      adUnitId = environment.androidInterstitialAdUnitId!;
    } else if (Platform.isIOS && environment.iOSInterstitialAdUnitID != null) {
      logger.i("👉 - testing interstitial ads");
      adUnitId = environment.iOSInterstitialAdUnitID!;
    }
    if (adUnitId.isEmpty) {
      logger.w("👉 - no interstitial ads setup");
      return;
    }
    // ---------------------------------
    // 👇 uncomment this to enable ads
    // Please see the pre requisites in the [ads guide](./docs/ad_mobs.md)
    // ---------------------------------

    // await InterstitialAd.load(
    //   adUnitId: adUnitId,
    //   request: const AdRequest(
    //     keywords: ["game", "quizz", "fun", "would you rather"],
    //   ),
    //   adLoadCallback: InterstitialAdLoadCallback(
    //     onAdLoaded: (InterstitialAd ad) {
    //       current = ad;
    //       _setAdCallbacks(
    //         onShow: onShow,
    //         onDismissed: onDismissed,
    //         onFailed: onFailed,
    //       );
    //       current!.show();
    //     },
    //     onAdFailedToLoad: (LoadAdError error) {
    //       debugPrint('InterstitialAd failed to load: $error');
    //     },
    //   ),
    // );
  }

  void _setAdCallbacks({
    OnAdsCallback? onShow,
    OnAdsCallback? onDismissed,
    OnAdsCallback? onFailed,
  }) {
    // ---------------------------------
    // 👇 uncomment this to enable ads
    // Please see the pre requisites in the [ads guide](./docs/ad_mobs.md)
    // ---------------------------------

    // current?.fullScreenContentCallback = FullScreenContentCallback(
    //   onAdShowedFullScreenContent: (InterstitialAd ad) {
    //     debugPrint('%ad onAdShowedFullScreenContent.');
    //     onShow?.call();
    //   },
    //   onAdDismissedFullScreenContent: (InterstitialAd ad) {
    //     debugPrint('$ad onAdDismissedFullScreenContent.');
    //     ad.dispose();
    //     onDismissed?.call();
    //   },
    //   onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
    //     debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
    //     ad.dispose();
    //     onFailed?.call();
    //   },
    //   onAdImpression: (InterstitialAd ad) {
    //     debugPrint('$ad impression occurred.');
    //     state = state.copyWith(lastAdShown: DateTime.now());
    //   },
    // );
  }
}
