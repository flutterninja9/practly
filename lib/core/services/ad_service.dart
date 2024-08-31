import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'database_service.dart';

class AdService {
  final DatabaseService _databaseService;
  final MobileAds _adService;

  AdService(this._databaseService, this._adService);

  Future<void> initializeAds() async {
    await _adService.initialize();
  }

  Future<void> loadAndShowRewardedAd(Function() onRewardEarned) async {
    await RewardedInterstitialAd.load(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/5354046379'
          : 'ca-app-pub-6987498065169755/8976301575',
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) async {
          await showRewardedAd(ad, onRewardEarned);
        },
        onAdFailedToLoad: (error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  Future<void> showRewardedAd(
    RewardedInterstitialAd ad,
    Function() onRewardEarned,
  ) async {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
      },
      onAdImpression: (ad) {
        debugPrint("Reward credited!");
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
      },
    );

    await ad.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
      // User earned reward, update the database
      await _databaseService.updateGenerationLimit();
      await onRewardEarned();
    });
  }

  Future<bool> canWatchAd() async {
    int adWatchCount = await _databaseService.getGenerationLimit();
    return adWatchCount < 5; // Assuming a limit of 5 ad watches
  }
}
