// import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 24, left: 10, right: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => imagePicker(context),
                child: Container(
                  height: 15.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Row(
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
              )
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
