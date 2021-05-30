import 'package:flutter/material.dart';
import 'package:lamtna/pages/NewTweetpage/NewTweetpage.dart';
import 'package:lamtna/pages/home/homepage.dart';
import 'package:lamtna/pages/profilepage/profilepage.dart';
import 'package:lamtna/pages/searchpage/searchpage.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavegtionControlPage extends StatefulWidget {
  int intialpage;

  NavegtionControlPage(this.intialpage);

  @override
  _NavegtionControlPageState createState() => _NavegtionControlPageState();
}

class _NavegtionControlPageState extends State<NavegtionControlPage> {
 // int _page = 0;
  List<Widget> pages = [
    HomePage(),
    searchPage(),
    NewTweetPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Container(padding: EdgeInsets.all(5), child: pages[widget.intialpage]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: mainRedColor, borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.all(3),
        child: SalomonBottomBar(

          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          currentIndex: widget.intialpage,
          onTap: _handelclick,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: mainDarkBluColor,
            ),

            /// search
            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("search"),
              selectedColor: mainDarkBluColor,
            ),

            /// NewTweets
            SalomonBottomBarItem(
              icon: Icon(Icons.whatshot),
              title: Text("New Tweet"),
              selectedColor: mainDarkBluColor,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: mainDarkBluColor,
            ),
          ],
        ),
      ),
    );
  }

  void _handelclick(int index) {
    setState(() {
      widget.intialpage= index;
    });
  }
}
