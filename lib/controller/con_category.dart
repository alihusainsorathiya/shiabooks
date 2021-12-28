import 'package:dio/dio.dart';

import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/model/category/model_category.dart';

Future<List<ModelCategory>> fetchCategory(List<ModelCategory> fetch) async {
  print("Base_url: " +
      Apiconstant().baseurl +
      Apiconstant().api +
      Apiconstant().category);
  var request = await Dio()
      .get(Apiconstant().baseurl + Apiconstant().api + Apiconstant().category);
  for (Map<String, dynamic> category in request.data) {
    fetch.add(ModelCategory(
        catId: category['cat_id'],
        photoCat: category['photo_cat'],
        name: category['name'],
        status: category['status']));
  }
  return fetch;
}
