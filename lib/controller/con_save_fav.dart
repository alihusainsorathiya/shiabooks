import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/view/widget/shared_pref.dart';

saveToFavourite(
    {required BuildContext context,
    required String idCourse,
    required String idUser}) async {
  var data = {'id_course': idCourse, 'id_user': idUser};

  var req = await Dio()
      .post(Apiconstant().baseurl + Apiconstant().saveFavourite, data: data);

  var checkFavorite = await Dio()
      .post(Apiconstant().baseurl + Apiconstant().checkFavourite, data: data);

//check if it is already saved

  (req.data == "success")
      ? await Alert(
          context: context,
          type: AlertType.success,
          onWillPopActive: false,
          title: 'Added to Favorite',
          desc: 'This Book has been added to your Favorites',
          style: AlertStyle(
            animationType: AnimationType.fromBottom,
            backgroundColor: Colors.white,
            titleStyle: TextStyle(
              color: Colors.black,
            ),
            descStyle: TextStyle(
              color: Colors.black54,
            ),
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                // save to favourites
                saveFavoriteEbook(checkFavorite.data);
              },
              child: Container(
                height: 45,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                child: Center(
                  child: Text(
                    'Okay',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              width: 100,
            ),
          ],
        ).show()
      // else part
      : await Alert(
          context: context,
          type: AlertType.warning,
          onWillPopActive: false,
          title: 'Remove from Favorite',
          desc: 'This Book has been removed from your Favorites',
          style: AlertStyle(
            animationType: AnimationType.fromBottom,
            backgroundColor: Colors.white,
            titleStyle: TextStyle(
              color: Colors.black,
            ),
            descStyle: TextStyle(
              color: Colors.black54,
            ),
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                // save to favourites
                saveFavoriteEbook(checkFavorite.data);
              },
              child: Container(
                height: 45,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                child: Center(
                  child: Text(
                    'Okay',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              width: 100,
            ),
          ],
        ).show();
}
