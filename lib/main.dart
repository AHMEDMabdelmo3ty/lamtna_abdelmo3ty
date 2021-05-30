import 'package:flutter/material.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/api/provider/tweetsprovider.dart';
import 'package:lamtna/control/navegtioncontrolpage.dart';
import 'package:lamtna/pages/welcamepage/welcmepage/welcamepage.dart';

SharedPreferences prefs;
UserModel myUserAccountData =
    UserModel(int.parse(prefs.getString('myid')), "", "", "", "", "");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token');
  Widget _screen;
  if (token == null || token == "") {
    _screen = WelcomePage(
      title: "LMATNA",
    );
  } else {
    _screen = NavegtionControlPage(0);
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => tweetsProvider(),
    )
  ], child: MyApp(screen: _screen)));
}

class MyApp extends StatelessWidget {
  final Widget screen;

  MyApp({this.screen});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'لمتنا ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: this.screen);
  }
}
