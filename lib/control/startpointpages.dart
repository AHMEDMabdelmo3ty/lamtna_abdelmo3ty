import 'package:flutter/material.dart';
import 'package:lamtna/pages/login%20page/logpage.dart';
import 'package:lamtna/pages/registerAccuontPage/signup.dart';

import 'package:lamtna/utilltos/constants.dart';

class StartPoint extends StatefulWidget {
  @override
  _StartPointState createState() => _StartPointState();
}

class _StartPointState extends State<StartPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainDarkBluColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                0.5,
                0.9,
                0.1
              ],
                  colors: [
                mainDarkBluColor,
                mainlightBluColor,
                mainDarkBluColor
              ])),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo,
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: 230,
                  height: 150,
                  child: Text(
                    'See what\'s Happening in the world right Now',
                    style: TextStyle(fontSize: 30, color: mainwhiteColor),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 290,
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'login To lmtna',
                              style: TextStyle(
                                  fontSize: 17, color: mainwhiteColor),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: mainwhiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: mainlightBluColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 290,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpPage();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Create New Account',
                              style: TextStyle(
                                  fontSize: 17, color: mainwhiteColor),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: mainlightBluColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: mainwhiteColor, width: 3)),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: mainwhiteColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}
