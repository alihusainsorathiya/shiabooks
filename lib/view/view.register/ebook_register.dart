import 'dart:io';
// import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/view/view.login/ebook_login.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EbookRegister extends StatefulWidget {
  const EbookRegister({Key? key}) : super(key: key);

  @override
  _EbookRegisterState createState() => _EbookRegisterState();
}

class _EbookRegisterState extends State<EbookRegister> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  File _file = File('');
  final picker = ImagePicker();
  bool enableLoading = false;

  Future Register(
      {required TextEditingController name,
      required TextEditingController email,
      required TextEditingController password,
      required BuildContext context,
      required Widget widget}) async {
    setState(() {
      enableLoading = true;
    });

    String getName = name.text;
    String getEmail = email.text;
    String getPassword = password.text;
    String registerUrl = Apiconstant().baseurl + Apiconstant().register;

    print(" Register Api URL:" + registerUrl);
    var request = http.MultipartRequest('POST', Uri.parse(registerUrl));
    var photo = await http.MultipartFile.fromPath('photo', _file.path);
    request.fields['name'] = getName;
    request.fields['email'] = getEmail;
    request.fields['password'] = getPassword;
    request.files.add(photo);

    var response = await request.send();
    debugPrint("Response Code :" + response.statusCode.toString());
    // print("register:" + response.stream.toString());

    print("register REQUEST:" + request.toString());
    print("register RESPONSE:" + response.toString());

    if (response.statusCode == 200) {
      setState(() {
        enableLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EbookLogin()));
    } else {
      setState(() {
        enableLoading = true;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Username or Email Already Exists.',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              actions: [
                GestureDetector(
                  child: Text("Okay"),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 14.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Create Your Account Right Now",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () {
                  imagePicker(context);
                },
                child: Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _file.path == ''
                          ? Image.asset(
                              'assets/images/noimageavailable.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _file,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              // NAME
              Container(
                margin:
                    EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 3.h),
                child: TextField(
                  controller: name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your Name',
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.black,
                    ),
                    filled: true,
                    isDense: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              // EMAIL
              Container(
                margin:
                    EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 17),
                child: TextField(
                  controller: email,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              // PASSWORD
              Container(
                margin:
                    EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 17),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  autofocus: false,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                      ),
                      filled: true,
                      isDense: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              // Register Button
              GestureDetector(
                onTap: () {
                  (_file.path != "")
                      ? (name.text != '')
                          ? (email.text != '')
                              ? (password.text != '')
                                  ? Register(
                                      name: name,
                                      email: email,
                                      password: password,
                                      context: context,
                                      widget: widget)
                                  : msgError('No Password',
                                      'Please write your password')
                              : msgError('No Email', 'Please write your email')
                          : msgError('No Name', 'Please write your name')
                      : msgError('No Photo', 'Please Choose your Photo');
                },
                child: Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
                  padding: EdgeInsets.only(
                      top: 1.2.h, bottom: 1.2.h, right: 1.5.w, left: 1.5.w),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: !enableLoading
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Visibility(
                          visible: enableLoading,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Container(
                                width: 19,
                                height: 19,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              // Already have an account - login here
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an Account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EbookLogin())),
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 17, color: Colors.blue),
                        ),
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

  Future msgError(String title, String description) {
    return Alert(
      context: context,
      type: AlertType.success,
      onWillPopActive: true,
      title: '$title',
      desc: '$description',
      style: AlertStyle(
        animationType: AnimationType.fromBottom,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(
          color: Colors.black,
        ),
        descStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      buttons: [
        DialogButton(
            padding: EdgeInsets.all(1),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 0.7),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true))
      ],
    ).show();
  }
}
