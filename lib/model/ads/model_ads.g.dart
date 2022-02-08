// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_ads.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelAds _$ModelAdsFromJson(Map<String, dynamic> json) {
  return ModelAds(
    ads: json['ads'] as String,
    startapplivemode: json['startapplivemode'] as String,
    startappaccountid: json['startappaccountid'] as String,
    androidappid: json['androidappid'] as String,
    iosappid: json['iosappid'] as String,
    admobreward: json['admobreward'] as String,
    banner: json['banner'] as String,
    interstitial: json['interstitial'] as String,
    unitylivemode: json['unitylivemode'] as String,
    unitygameid: json['unitygameid'] as String,
    unitybanner: json['unitybanner'] as String,
    unityinterstitial: json['unityinterstitial'] as String,
    unityreward: json['unityreward'] as String,
  );
}

Map<String, dynamic> _$ModelAdsToJson(ModelAds instance) => <String, dynamic>{
      'ads': instance.ads,
      'startapplivemode': instance.startapplivemode,
      'startappaccountid': instance.startappaccountid,
      'androidappid': instance.androidappid,
      'iosappid': instance.iosappid,
      'admobreward': instance.admobreward,
      'banner': instance.banner,
      'interstitial': instance.interstitial,
      'unitylivemode': instance.unitylivemode,
      'unitygameid': instance.unitygameid,
      'unitybanner': instance.unitybanner,
      'unityinterstitial': instance.unityinterstitial,
      'unityreward': instance.unityreward,
    };
