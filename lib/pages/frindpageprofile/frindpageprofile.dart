
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamtna/api/fetchData.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/widgets/tweetcard.dart';

// ignore: must_be_immutable
class Frinedprofilepage extends StatefulWidget {
  String myid ;

  Frinedprofilepage(this.myid);

  @override
  _FrinedprofilepageState createState() => _FrinedprofilepageState();
}

class _FrinedprofilepageState extends State<Frinedprofilepage> {
  FetchData _fetchData=FetchData();


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
                future: _fetchData.fetchAccuontById(widget.myid),
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
                          height: MediaQuery.of(context).size.height * 0.59,
                          child:Headerprofile(userModel: usermodel,)
                      );
                      break;
                  }
                },
              ),
            ),
            Container(
              child: FutureBuilder(
                future: _fetchData.fetchLoginUserTweet(widget.myid),
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
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).pop();},
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }

}

// ignore: must_be_immutable
class Headerprofile extends StatelessWidget {
  UserModel userModel;

  Headerprofile({
    Key key,
    this.userModel

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                child: (userModel.bannar!=null)?Image.network( main_URL+userModel.bannar,fit: BoxFit.cover,
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
                                image: (userModel.image!=null)?NetworkImage(
                                  main_URL + userModel.image,
                                ):AssetImage("images/null.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),

                  ],
                ),

              ) ,

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:100.0,bottom: 100),
            child: Column(
              children: [
                Text(userModel.fullname,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text("@${userModel.username}",style: TextStyle(fontSize: 15),),
              ],
            ),
          ),
          Divider(
            height: 2,
            indent: 2,
            color: Colors.grey[200],
            thickness: 5,
          )
        ],
      ),
    );
  }
}
