import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiabooks/controller/api.dart';
import 'package:shiabooks/view/view.bottom_view/bottom_view.dart';
import 'package:shiabooks/view/view.register/ebook_register.dart';
import 'package:shiabooks/view/widget/ebook_router.dart';
import 'package:shiabooks/view/widget/shared_pref.dart';
import 'package:sizer/sizer.dart';

class EbookLogin extends StatefulWidget {
  @override
  _EbookLoginState createState() => _EbookLoginState();
}

class _EbookLoginState extends State<EbookLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool enableLoading = false;

  Future Login(
      {required TextEditingController email,
      required TextEditingController password,
      required BuildContext context,
      required Widget widget}) async {
    String getEmail = email.text;
    String getPassword = password.text;

    setState(() {
      enableLoading = true;
    });

    var data = {'email': getEmail, 'password': getPassword};
    var loginurl = Apiconstant().baseurl + Apiconstant().login;

    print(" Login Api URL:" + loginurl);
    var request = await Dio().post(loginurl.toString(), data: data);
    var decodedData = jsonDecode(request.data);

    if (decodedData[4] == "Successfully login") {
      setState(() {
        enableLoading = false;
        //storing data in saved preference
        saveLogin(
            id: decodedData[0],
            name: decodedData[1],
            email: decodedData[2],
            photo: '');

        // Navigate to Home page with back button disabled
        pushAndRemove(context, BottomView());
      });
    } else {
      setState(() {
        enableLoading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Please double check your Email and Password.',
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
  void initState() {
    super.initState();
    loadLogin().then((value) => setState(() {
          value != null ? pushAndRemove(context, BottomView()) : {};
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 70),
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/shiabooklogo.png',
                  width: 125,
                  height: 125,
                ),
                Text(
                  'Hello, Welcome Back !',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
                // EMAIL
                Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 7.h),
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
                // Login Button
                GestureDetector(
                  onTap: () {
                    Login(
                        email: email,
                        password: password,
                        context: context,
                        widget: widget);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, bottom: 10, top: 10),
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
                              "Login",
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
                // Don't have an account? Sign up
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, bottom: 5, top: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account?",
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
                                builder: (context) => EbookRegister(),
                              ),
                            ),
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 17, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
