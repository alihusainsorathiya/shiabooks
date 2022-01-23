// import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/view/view.login/ebook_login.dart';
import 'package:shiabooks/view/widget/ebook_router.dart';
import 'package:shiabooks/view/widget/shared_pref.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class BottomProfile extends StatefulWidget {
  const BottomProfile({Key? key}) : super(key: key);

  @override
  _BottomProfileState createState() => _BottomProfileState();
}

class _BottomProfileState extends State<BottomProfile> {
  String id = '', name = '', email = '', userPhoto = '';
  late SharedPreferences preferences;
  File _file = File('');
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    loadLogin().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        // getFavorite = fetchFavorite(listFavorite, id);
        displayPhotofromDB(id);
      });
    });
  }

  Future updateUserPhoto() async {
    var req = http.MultipartRequest(
        'POST', Uri.parse(Apiconstant().baseurl + Apiconstant().updatePhoto));
    req.fields['iduser'] = id;
    var photo = await http.MultipartFile.fromPath('photo', _file.path);
    req.files.add(photo);

    var response = await req.send();
    (response.statusCode == 200)
        // ignore: unnecessary_statements
        ? {
            setState(() {
              _file = File('');
            }),
            displayPhotofromDB(id),
          }
        : print("Photofrom DB : " + response.statusCode.toString());
  }

  Future displayPhotofromDB(String userId) async {
    var request = await Dio().post(
        Apiconstant().baseurl + Apiconstant().viewPhoto,
        data: {'id': userId});
    var decode = request.data;
    decode != 'no_img'
        ? setState(() {
            userPhoto = decode;
          })
        : setState(() {
            userPhoto = '';
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              updateUserPhoto();
            },
            child: _file.path != ''
                ? Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  )
                : Text(""),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 24, left: 10, right: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  imagepicker
              GestureDetector(
                onTap: () => imagePicker(context),
                child: Container(
                  height: 15.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userPhoto != ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                '$userPhoto',
                                fit: BoxFit.cover,
                                width: 30.w,
                                height: 30.h,
                              ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/images/noimageavailable.png',
                                fit: BoxFit.cover,
                                width: 30.w,
                                height: 30.h,
                              ),
                            ),
                      _file.path == ''
                          ? Text("")
                          : Text(
                              'Change to =>',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                      _file.path == ''
                          ? Text("")
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: _file.path == ''
                                  ? Image.asset(
                                      'assets/images/noimageavailable.png',
                                      fit: BoxFit.cover,
                                      width: 30.w,
                                      height: 30.h,
                                    )
                                  : Image.file(
                                      _file,
                                      fit: BoxFit.cover,
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                            ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
              //  name and email
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      email,
                      style: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 25.sp),
                  child: Text(
                    'Shiabooks App Support',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 15.sp),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Row(
                      children: [
                        Text(
                          'About Shiabooks ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 15.sp),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Row(
                      children: [
                        // SizedBox(
                        //   width: 10.sp,
                        // ),
                        Text(
                          'Rate us 5 ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 15.sp),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Row(
                      children: [
                        Text(
                          'Share this App ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.share,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async => {
                  preferences = await SharedPreferences.getInstance(),
                  preferences.remove('login'),
                  preferences.clear(),
                  print('logged out'),
                  pushAndRemove(context, EbookLogin()),
                },
                child: Container(
                  width: 30.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black54,
                          blurRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Logout  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  imageFromGallery() async {
    var imgFromGallery = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 100,
        maxWidth: 100);

    setState(() {
      imgFromGallery == null
          // ignore: unnecessary_statements
          ? {
              debugPrint("ImgFromGallery::" + imgFromGallery.toString()),
              print("ImgFromGallery::" + imgFromGallery.toString())
            }
          : _file = File(imgFromGallery.path);
    });
  }

  imageFromCamera() async {
    var imgFromCamera = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 100,
        maxWidth: 100);
    setState(() {
      imgFromCamera == null
          // ignore: unnecessary_statements
          ? {
              debugPrint("ImgFromGallery::" + imgFromCamera.toString()),
              print("ImgFromGallery::" + imgFromCamera.toString())
            }
          : _file = File(imgFromCamera.path);
    });
  }

  void imagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.library_add,
                    color: Colors.blue,
                  ),
                  title: Text("Photo From Gallery"),
                  onTap: () => {
                    imageFromGallery(),
                    Navigator.pop(context),
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                  ),
                  title: Text("Photo From Camera"),
                  onTap: () => {
                    imageFromCamera(),
                    Navigator.pop(context),
                  },
                ),
              ],
            ),
          );
        });
  }
}
