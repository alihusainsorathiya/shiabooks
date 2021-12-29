import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EbookRegister extends StatefulWidget {
  const EbookRegister({Key? key}) : super(key: key);

  @override
  _EbookRegisterState createState() => _EbookRegisterState();
}

class _EbookRegisterState extends State<EbookRegister> {
  File _file = File('');
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 17.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Create Your Account Right Now",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin:
                      EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(Icons.account_circle_outlined),
                  ),
                ),
              ),
              // NAME
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 5),
                child: TextField(
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
                      )),
                ),
              ),
              // EMAIL
              Container(
                margin:
                    EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 17),
                child: TextField(
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
                  obscureText: true,
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

              //
            ],
          ),
        ),
      ),
    );
  }
}
