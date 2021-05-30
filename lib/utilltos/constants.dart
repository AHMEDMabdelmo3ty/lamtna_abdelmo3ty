
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// الوان البرنامج الرائيسية
final mainDarkBluColor =Color(0xff0756ff);
final mainlightBluColor =Color(0xff4ca1ef);
final mainwhiteColor =Color(0xfffff9ee);
final mainOrangeColor =Color(0xffe36414);
final mainblackColor =Color(0xff404040);
final mainRedColor =Color(0xff9a031e);
final mainDarkRedColor =Color(0xff5f0f40);
final mainDarkGreyColor =Color(0xff0f4c5c);










//اللوجو الخاص بالبرنامج
final Widget logo =  Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('L',style: TextStyle(fontSize: 50,color: Colors.white),),
    Icon(FontAwesomeIcons.mediumM,size: 50,color: Colors.white,),
    Icon(FontAwesomeIcons.tumblr,size: 50,color: Colors.white,),
    Text('na',style: TextStyle(fontSize: 50,color: Colors.white),),
    Icon(FontAwesomeIcons.angellist,size: 50,color: Colors.white,),

  ],
);
// url in project
// ignore: non_constant_identifier_names
final main_URL ="http://10.0.2.2:1337";
// ignore: non_constant_identifier_names
final register_URL = main_URL+"/auth/local/register";
// ignore: non_constant_identifier_names
final Login_URL = main_URL+"/auth/local/";
// ignore: non_constant_identifier_names
final Tweet_URL = main_URL+"/Tweets/";
// ignore: non_constant_identifier_names
final loginUser_Tweet_URL = main_URL+"/Tweets?users_permissions_user=";
// ignore: non_constant_identifier_names
final MyAccuont_URL = main_URL+"/users/me/";
// ignore: non_constant_identifier_names
final User_URL = main_URL+"/users/";
// ignore: non_constant_identifier_names
final like_URL = main_URL+"/likes/";
// ignore: non_constant_identifier_names
final search_URL = main_URL+"/tweets?description_contains=";




