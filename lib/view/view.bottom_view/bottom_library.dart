import 'package:flutter/material.dart';
import 'package:shiabooks/controller/con_latest.dart';
import 'package:shiabooks/model/model.ebook/model_ebook.dart';
import 'package:sizer/sizer.dart';

class BottomLibrary extends StatefulWidget {
  const BottomLibrary({Key? key}) : super(key: key);

  @override
  _BottomLibraryState createState() => _BottomLibraryState();
}

class _BottomLibraryState extends State<BottomLibrary> {
  Future<List<ModelEbook>>? getLatest;
  List<ModelEbook> listLatest = [];

  @override
  void initState() {
    super.initState();
    getLatest = fetchLatest(listLatest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          "Library",
          style: TextStyle(color: Colors.black),
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
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  listLatest[index].photo,
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
                                  listLatest[index].title,
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
