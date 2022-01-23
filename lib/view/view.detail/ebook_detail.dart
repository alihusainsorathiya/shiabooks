import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/controller/con_detail.dart';
import 'package:shiabooks/controller/con_save_fav.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';
import 'package:shiabooks/view/widget/shared_pref.dart';
import 'package:sizer/sizer.dart';

class EbookDetail extends StatefulWidget {
  int ebookId;
  int status;
  String ebookName;

  EbookDetail(
      {required this.ebookId, required this.status, required this.ebookName});

  @override
  _EbookDetailState createState() => _EbookDetailState();
}

class _EbookDetailState extends State<EbookDetail> {
  Future<List<ModelEbook>>? getDetail;
  List<ModelEbook> listDetail = [];
  String name = '', email = '', id = '', checkFavorite = "0";

  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getDetail = fetchDetail(listDetail, widget.ebookId);
    loadLogin().then((value) => {
          id = value[0],
          name = value[1],
          email = value[2],
          checkFavourites(id)
        });
  }

  checkFavourites(String userId) async {
    var data = {'id_course': widget.ebookId, 'id_user': userId};

    var checkFav = await Dio()
        .post(Apiconstant().baseurl + Apiconstant().checkFavourite, data: data);
    var response = checkFav.data;
    setState(() {
      checkFavorite = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          widget.ebookName.toString(),
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: getDetail,
            builder: (BuildContext context,
                AsyncSnapshot<List<ModelEbook>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(14),
                                height: 25.h,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        listDetail[index].photo,
                                        fit: BoxFit.cover,
                                        width: 35.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listDetail[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 1.3.h,
                                          ),
                                          Text(
                                            'Author: ${listDetail[index].authorName}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 1.3.h,
                                          ),
                                          Text(
                                            'Publisher: ${listDetail[index].publisherName}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await showDialog(
                                                    builder: (myFavorite) =>
                                                        FutureProgressDialog(
                                                      saveToFavourite(
                                                          context: myFavorite,
                                                          idCourse: widget
                                                              .ebookId
                                                              .toString(),
                                                          idUser: id),
                                                    ),
                                                    context: context,
                                                  ).then((value) async {
                                                    preferences =
                                                        await SharedPreferences
                                                            .getInstance();

                                                    dynamic fav = preferences
                                                        .get('saveFavorite');
                                                    setState(() {
                                                      checkFavorite = fav;
                                                    });
                                                  });
                                                },
                                                child: (checkFavorite ==
                                                        "already")
                                                    ? Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                        size: 21.sp,
                                                      )
                                                    : Icon(Icons
                                                        .favorite_border_rounded),
                                              ),
                                              SizedBox(
                                                width: 1.3.h,
                                              ),
                                              Text(
                                                '${listDetail[index].pages} pages',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                              SizedBox(
                                                width: 1.h,
                                              ),
                                              listDetail[index].free == 1
                                                  ? Text(
                                                      'Free',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                    )
                                                  : Text(
                                                      'Premium',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15),
                                                    ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  _share();
                                                },
                                                child: Icon(
                                                  Icons.share,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.h),
                              widget.status == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Coming Soon",
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.only(left: 14, right: 14),
                                    )
                                  : widget.status == 1
                                      ? GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Read Ebook (Free)",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "Read Ebook (Premium)",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                              SizedBox(height: 3.h),
                              Container(
                                padding: EdgeInsets.only(top: 3.h),
                                margin: EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Html(
                                      data: '${listDetail[index].description}',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.h),
                            ],
                          );
                        }),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Colors.blue,
                  ),
                );
              }
            }),
      ),
    );
  }

  _share() async {
    PackageInfo pi = await PackageInfo.fromPlatform();
    Share.share(
        "Reading Ebook for free on ${pi.appName} '\n Download Now :https://play.google.com/store/apps/details?id=${pi.packageName} ");
  }
}
