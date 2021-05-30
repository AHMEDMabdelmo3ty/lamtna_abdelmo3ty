import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamtna/api/fetchData.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/provider/tweetsprovider.dart';
import 'package:lamtna/pages/frindpageprofile/frindpageprofile.dart';
import 'package:lamtna/pages/tweetDetailespage/tweetDetailespage.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/widgets/logo.dart';
import 'package:provider/provider.dart';

class NewTweetPage extends StatefulWidget {
  @override
  _NewTweetPageState createState() => _NewTweetPageState();
}

class _NewTweetPageState extends State<NewTweetPage> {
  int cont = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Logo(
            size: 35,
            color: mainDarkBluColor,
          ),
          centerTitle: true,
          actions: [Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.settings,color: mainDarkBluColor,),
          )],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("TOP 6 posts",style: TextStyle(color: mainDarkBluColor,fontSize: 25),),
              ),),
              Container(
                  height: MediaQuery.of(context).size.height * 6,
                  child: Container(
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

                            return (tweets.length == 0)
                                ? Container(
                                    child: Center(
                                      child: Text("no tweets"),
                                    ),
                                  )
                                : Container(
                                    child: (tweets.length >= 7)
                                        ? Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.80,
                                            child: ListView.builder(
                                                itemCount: 6,
                                                itemBuilder: (context, index) {
                                                  return NewTweetNavigtionPage(
                                                      tweets[index]);
                                                }),
                                          )
                                        : Text("data"),
                                  );
                            break;
                        }
                      },
                    ),
                  ))
            ],
          ),
        ));
  }
  // ignore: non_constant_identifier_names
  Widget NewTweetNavigtionPage(TweetModel tweet) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TweetDetailespage(tweet)));
      },
      child: Card(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Frinedprofilepage(
                        tweet.tweetUserid.toString())));
              },
              child: Container(
                width: 60,
                height: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    image: DecorationImage(
                        image: (tweet.image == null)
                            ? AssetImage('images/null.jpg')
                            : NetworkImage(main_URL + tweet.image),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'the is new tweet',
                          style: TextStyle(
                              color: mainDarkBluColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Icon(
                          Icons.blur_on,
                          color: mainlightBluColor,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        tweet.description,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

