import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shiabooks/controller/con_category.dart';
import 'package:shiabooks/controller/con_latest.dart';
import 'package:shiabooks/controller/con_slider.dart';
import 'package:shiabooks/controller/con_incoming.dart';
import 'package:shiabooks/model/category/model_category.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';
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

  void initState() {
    super.initState();

    getSlider = fetchSlider(listSlider);
    getLatest = fetchLatest(listLatest);
    getIncoming = fetchIncoming(listIncoming);
    getCategory = fetchCategory(listCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {},
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
                                                      Container(
                                                        width: 24.w,
                                                        child: Text(
                                                          listIncoming[index]
                                                              .title,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
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
