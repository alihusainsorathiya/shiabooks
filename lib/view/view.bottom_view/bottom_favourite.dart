import 'package:flutter/material.dart';
import 'package:shiabooks/controller/con_favorite.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';
import 'package:shiabooks/view/widget/shared_pref.dart';
import 'package:sizer/sizer.dart';

class BottomFavourite extends StatefulWidget {
  const BottomFavourite({Key? key}) : super(key: key);

  @override
  _BottomFavouriteState createState() => _BottomFavouriteState();
}

class _BottomFavouriteState extends State<BottomFavourite> {
  Future<List<ModelEbook>>? getFavorite;
  List<ModelEbook> listFavorite = [];
  String id = '', name = '', email = '', photo = '';

  @override
  void initState() {
    super.initState();
    loadLogin().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getFavorite = fetchFavorite(listFavorite, id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
              future: getFavorite,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ModelEbook>> snapshot) {
                print("snapshot status : " + snapshot.hasData.toString());
                print("length:::" + snapshot.toString());
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData == true)

                // if (snapshot != null) {
                {
                  print("Length:  " + snapshot.data!.length.toString());
                  print("Length:  " + snapshot.hasData.toString());
                  return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 5.5 / 9.0),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  listFavorite[index].photo,
                                  fit: BoxFit.cover,
                                  height: 15.h,
                                  width: 24.w,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              SizedBox(
                                // height: 0.5.h,
                                height: 0.7,
                              ),
                              Container(
                                width: 24.w,
                                child: Text(
                                  listFavorite[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
      ),
    );
  }
}
