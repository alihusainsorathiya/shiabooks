import 'dart:io';

import 'package:startapp_sdk_flutter/startapp_sdk_flutter.dart';

Future<void> initApp(
    String androidAppId, String iosAppId, String accountId) async {
  Startapp.instance.initialize(
      appId: Platform.isAndroid ? androidAppId : iosAppId,
      accountId: accountId);
}

void handleAds(StartappEvent event) {
  switch (event) {
    case StartappEvent.onClick:
      print('user clicked on the ad');
      break;

    case StartappEvent.onReceiveAd:
      print('user received on the ad');
      break;

    case StartappEvent.onFailedToReceiveAd:
      print('user failed to receive the ad');
      break;

    case StartappEvent.onImpression:
      print('user received on the Impression ad');
      break;

    default:
  }
}
