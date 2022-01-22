import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/controller/con_category.dart';
import 'package:shiabooks/controller/con_latest.dart';
import 'package:shiabooks/controller/con_slider.dart';
import 'package:shiabooks/controller/con_incoming.dart';
import 'package:shiabooks/model/category/model_category.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';
import 'package:shiabooks/view/view.detail/ebook_detail.dart';
import 'package:shiabooks/view/widget/ebook_router.dart';
import 'package:shiabooks/view/widget/shared_pref.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<ModelEbook>>? getSlider;
  List<ModelEbook> listSlider = [];

  Future<List<ModelEbook>>? getLatest;
  List<ModelEbook> listLatest = [];

  Future<List<ModelEbook>>? getIncoming;
  List<ModelEbook> listIncoming = [];

  Future<List<ModelCategory>>? getCategory;
  List<ModelCategory> listCategory = [];

  String id = '', name = '', email = '', photo = '';

  @override
  void initState() {
    super.initState();

    getSlider = fetchSlider(listSlider);
    getLatest = fetchLatest(listLatest);
    getIncoming = fetchIncoming(listIncoming);
    getCategory = fetchCategory(listCategory);
    loadLogin().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        // photo = value[3];
        getPhotoFromDB(id);
      });
    });
  }

// get photo from DB

  Future getPhotoFromDB(String idOfUser) async {
    String photoFromDbUrl = Apiconstant().baseurl + Apiconstant().viewPhoto;
    print("URL Photo from DB:" + photoFromDbUrl);
    var req = await Dio().post(photoFromDbUrl, data: {'id': idOfUser});
    var decode = req.data;

    decode != "no_img"
        ? setState(
            () => photo = decode,
          )
        : setState(() => photo = "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Row(
          children: [
            Container(
              // photo from db
              child: photo == ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      child: Image.asset(
                        // 'assets/images/register.png',
                        'assets/images/shiabooklogo.png',
                        fit: BoxFit.cover,
                        width: 14.w,
                        height: 7.h,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                      child: Image.network(
                        photo,
                        fit: BoxFit.cover,
                        width: 14.w,
                        height: 7.h,
                      ),
                    ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              name,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getSlider,
            builder: (BuildContext context,
                AsyncSnapshot<List<ModelEbook>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Column(
                  children: [
                    // Slider
                    Container(
                      child: FutureBuilder(
                        future: getSlider,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ModelEbook>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done)
                            return SizedBox(
                              height: 27.0.h,
                              child: Swiper(
                                autoplay: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      pushPage(
                                          context,
                                          EbookDetail(
                                            ebookId: listSlider[index].id,
                                            status:
                                                listSlider[index].statusNews,
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              child: Image.network(
                                                listSlider[index].photo,
                                                fit: BoxFit.cover,
                                                width: 100.0.w,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15)),
                                                  gradient: LinearGradient(
                                                    end: Alignment(0.0, -1),
                                                    begin: Alignment(0.0, 0.2),
                                                    colors: [
                                                      Colors.black,
                                                      Colors.black
                                                          .withOpacity(0.3),
                                                    ],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    listSlider[index].title,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          else
                            return Container();
                        },
                      ),
                    ),

                    // Latest Ebook
                    Container(
                      child: FutureBuilder(
                        future: getLatest,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ModelEbook>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done)
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Latest Ebooks",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 17),
                                  ),
                                ),
                                SizedBox(
                                  height: 22.h,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length + 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index == snapshot.data!.length) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 24.w,
                                            padding: EdgeInsets.only(top: 15.w),
                                            child: Text(
                                              "See All",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(6),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  child: Image.network(
                                                    listLatest[index].photo,
                                                    fit: BoxFit.cover,
                                                    height: 15.h,
                                                    width: 24.w,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Container(
                                                  width: 24.w,
                                                  child: Text(
                                                    listLatest[index].title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          else
                            return Container();
                        },
                      ),
                    ),
                    // ADS
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ModelEbook>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return snapshot.data!.length == 0
                                ? Container()
                                : Container(
                                    color: Colors.blueGrey.withOpacity(0.5),
                                    padding: EdgeInsets.only(top: 2.0.h),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5.h),
                                              child: Text(
                                                'Coming Soon',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  letterSpacing: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24.h,
                                          child: ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        child: Image.network(
                                                          listIncoming[index]
                                                              .photo,
                                                          fit: BoxFit.cover,
                                                          height: 15.h,
                                                          width: 24.w,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      SizedBox(
                                                        height: 0.5.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          } else
                            return Container();
                        },
                        future: getIncoming,
                      ),
                    ),
                    //COMING SOON
                    Container(
                      child: FutureBuilder(
                          future: getCategory,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ModelCategory>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done)
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Category',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                    child: ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    child: Image.network(
                                                      listCategory[index]
                                                          .photoCat,
                                                      fit: BoxFit.cover,
                                                      height: 15.h,
                                                      width: 24.w,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  ClipRRect(
                                                    child: Container(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      height: 15.h,
                                                      width: 24.w,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    bottom: 0,
                                                    right: 0,
                                                    left: 0,
                                                    child: Center(
                                                      child: Text(
                                                        listCategory[index]
                                                            .name,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              );
                            else
                              return Container();
                          }),
                    ),
                    // CATEGORY
                  ],
                );
              else
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
