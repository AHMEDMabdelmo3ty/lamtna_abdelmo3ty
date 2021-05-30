import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamtna/api/fetchData.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/api/sherdpref.dart';
import 'package:lamtna/main.dart';
import 'package:lamtna/pages/editprofilepage/editprofilepage.dart';
import 'package:lamtna/pages/welcamepage/welcmepage/welcamepage.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/widgets/tweetcard.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FetchData _fetchData = FetchData();
  String myid = prefs.getString("myid");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                future: _fetchData.fetchAccuontById(myid),
                // ignore: missing_return
                builder: (context, snapchot) {
                  // ignore: missing_return
                  switch (snapchot.connectionState) {
                    case ConnectionState.active:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      UserModel usermodel = snapchot.data;

                      return Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.556,
                          child: Headerprofile(userModel: usermodel,)
                      );
                      break;
                  }
                },
              ),
            ),
            Container(
              child: FutureBuilder(
                future: _fetchData.fetchLoginUserTweet(myid),
                // ignore: missing_return
                builder: (context, snapchot) {
                  // ignore: missing_return
                  switch (snapchot.connectionState) {
                    case ConnectionState.active:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.done:
                      List<TweetModel> tweets =
                      snapchot.data.reversed.toList();

                      return Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.80,
                        child: ListView.builder(
                            itemCount: tweets.length,
                            itemBuilder: (context, index) {
                              return TweetCard(
                                context: context,
                                tweet: tweets[index],
                              );
                            }),
                      );
                      break;
                  }
                },
              ),
            )


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        onPressed: () {
        SharedPref.savetoken("", "");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WelcomePage()));
      },
        child: Icon(FontAwesomeIcons.signOutAlt),
      ),
    );
  }

}

class Headerprofile extends StatelessWidget {
  UserModel userModel;

  Headerprofile({
    Key key,
    this.userModel

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
        Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.25,
            child:(userModel.bannar!=null) ?Image.network(main_URL + userModel.bannar, fit: BoxFit.cover,
            ):Image.asset("images/null.jpg"),
          ),
          Transform.translate(
            offset: Offset(115, 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        image: DecorationImage(
                            image:(userModel.image!=null) ? NetworkImage(
                                main_URL + userModel.image
                            ):AssetImage("images/null.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),

              ],
            ),

          ),
        ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120.0, bottom:10),
            child: Column(
              children: [
                Text(userModel.fullname,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text("@${userModel.username}", style: TextStyle(fontSize: 15),),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: mainlightBluColor, width: 2),
                    color: mainblackColor,),

                  child: FlatButton(
                    onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditProfilePage(userModel)));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.settings,color: mainwhiteColor,),
                        Text("Edit profile",style: TextStyle(color: mainlightBluColor,fontSize: 20),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
