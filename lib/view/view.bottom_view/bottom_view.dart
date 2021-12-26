import 'package:flutter/material.dart';
import 'package:shiabooks/view/view.bottom_view/bottom_favourite.dart';
import 'package:shiabooks/view/view.bottom_view/bottom_library.dart';
import 'package:shiabooks/view/view.bottom_view/bottom_profile.dart';
import 'package:shiabooks/view/view.bottom_view/home.dart';

class BottomView extends StatefulWidget {
  const BottomView({Key? key}) : super(key: key);

  @override
  _BottomViewState createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  int currentIndex = 0;
  List<Widget> body = [
    Home(),
    BottomLibrary(),
    BottomFavourite(),
    BottomProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapBottomView,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_sharp),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
            ),
          ],
        ),
        body: body[currentIndex],
      ),
    );
  }

  void onTapBottomView(int index) {
    print(index);
    setState(() {
      currentIndex = index;
    });
  }
}
