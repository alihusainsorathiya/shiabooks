import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class UnityManager {
  String gameId(String androidGameId, String iOSGameId) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return androidGameId;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return iOSGameId;
    }

    return '';
  }

  String bannerAdsPlacementId(String androidBanner) {
    return androidBanner;
  }

  String interstitialAdsPlacementId(String androidInterstitial) {
    return androidInterstitial;
  }

  String rewardAdsPlacementId(String androidReward) {
    return androidReward;
  }
}

class UnityInit {
  getInit(String androidGameId, String iosGameId, String testMode) {
    UnityAds.init(
      gameId: UnityManager().gameId(androidGameId, iosGameId),
      testMode: testMode == '0' ? true : false,
      onComplete: () => print('Initialization Complete'),
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
  }
}
