import 'package:json_annotation/json_annotation.dart';
part 'model_ads.g.dart';

@JsonSerializable()
class ModelAds {
  String ads;
  String startapplivemode;
  String startappaccountid;
  String androidappid;
  String iosappid;
  String admobreward;
  String banner;
  String interstitial;
  String unitylivemode;
  String unitygameid;
  String unitybanner;
  String unityinterstitial;
  String unityreward;

  ModelAds(
      {required this.ads,
      required this.startapplivemode,
      required this.startappaccountid,
      required this.androidappid,
      required this.iosappid,
      required this.admobreward,
      required this.banner,
      required this.interstitial,
      required this.unitylivemode,
      required this.unitygameid,
      required this.unitybanner,
      required this.unityinterstitial,
      required this.unityreward});

  factory ModelAds.fromJson(Map<String, dynamic> json) =>
      _$ModelAdsFromJson(json);

  // ModelAds toJson() => _$ModelAdsFromJson(this);
  Map<String, dynamic> toJson() => _$ModelAdsToJson(this);
}
