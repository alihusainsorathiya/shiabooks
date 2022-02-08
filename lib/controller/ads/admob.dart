import 'dart:io';

class AdMobManager {
  String bannerAdsUnitId(String androidBanner, String iOSBanner) {
    if (Platform.isAndroid) {
      return androidBanner;
    } else if (Platform.isIOS) {
      return iOSBanner;
    } else
      throw new UnsupportedError('No Platform Found');
  }

  String interStitialAdsUnitId(String androidBanner, String iOSBanner) {
    if (Platform.isAndroid) {
      return androidBanner;
    } else if (Platform.isIOS) {
      return iOSBanner;
    } else
      throw new UnsupportedError('No Platform Found');
  }

  String rewardslAdsUnitId(String androidBanner, String iOSBanner) {
    if (Platform.isAndroid) {
      return androidBanner;
    } else if (Platform.isIOS) {
      return iOSBanner;
    } else
      throw new UnsupportedError('No Platform Found');
  }
}
