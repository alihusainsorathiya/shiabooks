import 'package:dio/dio.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/model/ads/model_ads.dart';

Future<List<ModelAds>> fetchAds() async {
  var req = await Dio()
      .get(Apiconstant().baseurl + Apiconstant().api + Apiconstant().ads);

  var adsData = req.data;

  List<ModelAds> adsFetchFromServer = [];

  for (Map<String, dynamic> ad in adsData) {
    adsFetchFromServer.add(ModelAds(
        ads: ad['ads'],
        startapplivemode: ad['startapplivemode'],
        startappaccountid: ad['startappaccountid'],
        androidappid: ad['androidappid'],
        iosappid: ad['iosappid'],
        admobreward: ad['admobreward'],
        banner: ad['banner'],
        interstitial: ad['interstitial'],
        unitylivemode: ad['unitylivemode'],
        unitygameid: ad['unitygameid'],
        unitybanner: ad['unitybanner'],
        unityinterstitial: ad['unityinterstitial'],
        unityreward: ad['unityreward']));
  }

  return adsFetchFromServer;
}
