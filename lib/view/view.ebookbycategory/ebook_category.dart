import 'package:flutter/material.dart';
import 'package:shiabooks/controller/con_categorydetail.dart';
import 'package:shiabooks/controller/con_latest.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';
import 'package:shiabooks/view/view.detail/ebook_detail.dart';
import 'package:shiabooks/view/widget/ebook_router.dart';
import 'package:sizer/sizer.dart';

class EbookCategory extends StatefulWidget {
  int catId;
  String catName;
  EbookCategory({required this.catId, required this.catName});

  @override
  _EbookCategoryState createState() => _EbookCategoryState();
}

class _EbookCategoryState extends State<EbookCategory> {
  Future<List<ModelEbook>>? getLatest;
  List<ModelEbook> listEbookByCategory = [];

  @override
  void initState() {
    super.initState();
    getLatest = fetchEbookByCategory(listEbookByCategory, widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          widget.catName,
          style: TextStyle(color: Colors.black),
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
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: getLatest,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ModelEbook>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 5.5 / 9.0),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => pushPage(
                            context,
                            EbookDetail(
                              ebookId: listEbookByCategory[index].id,
                              status: listEbookByCategory[index].statusNews,
                              ebookName:
                                  listEbookByCategory[index].title.toString(),
                            )),
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  listEbookByCategory[index].photo,
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
                                  listEbookByCategory[index].title,
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
