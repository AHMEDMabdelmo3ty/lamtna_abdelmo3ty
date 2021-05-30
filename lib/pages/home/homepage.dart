import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/api/provider/tweetsprovider.dart';
import 'package:lamtna/main.dart';
import 'package:lamtna/pages/CreateTweetpage/CreateTweetPage.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/widgets/logo.dart';
import 'package:lamtna/widgets/tweetcard.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {

  // ignore: non_constant_identifier_names
  UserModel MyUserAccountData= UserModel(int.parse(prefs.getString('myid' )), "", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Logo(
            size: 35,
            color: mainDarkRedColor,
          ),
          actions: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.fontAwesome,
                  color: mainRedColor,
                ),
                onPressed: () {})
          ],
        ),
        floatingActionButton: FloatingActionButton(backgroundColor: mainOrangeColor,
          child: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return CreateTweetPage(main_URL+MyUserAccountData.image);
            }));
          },
        ),
        backgroundColor: Colors.white60,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: FutureBuilder(
                    future: Provider.of<tweetsProvider>(context).fetchTweet(),
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
                            height: MediaQuery.of(context).size.height * 0.80,
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
        ));
  }
}
