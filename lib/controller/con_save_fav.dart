import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shiabooks/controller/api.dart';

saveToFavourite(
    {required BuildContext context,
    required String idCourse,
    required String idUser}) async {
  var data = {'id_course': idCourse, 'id_user': idUser};

  var req = await Dio()
      .post(Apiconstant().baseurl + Apiconstant().saveFavourite, data: data);

  var checkFavorite = "";
}
