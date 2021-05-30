import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  static Future savetoken(String token ,String myid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
  prefs.setString('myid', myid);
  }

}


