import 'package:flutter/material.dart';
import 'package:lamtna/api/fetchData.dart';
import 'package:lamtna/api/model/commentmodel.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/api/provider/tweetsprovider.dart';
import 'package:lamtna/control/navegtioncontrolpage.dart';
import 'package:lamtna/pages/CreateCommentpage/createcommentpage.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/widgets/tweetcard.dart';
import 'package:provider/provider.dart';

class TweetDetailespage extends StatelessWidget {


  FetchData _fetchData = FetchData();
  TweetModel tweet;

  TweetDetailespage(this.tweet);

  @override
  Widget build(BuildContext context) {
    return Consumer<tweetsProvider>(
      builder: (build,val,child)=> Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: FlatButton(
            child: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => NavegtionControlPage(0)));
            },
          ),
        ),
        backgroundColor: Colors.blue[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
         TweetCard(context: context, tweet: tweet,),
              Text('Comments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Container(
                height: 300,
                child: ListView.builder(
                    itemCount: tweet.comments.length,
                    itemBuilder: (context, index) {
                      List <Commentmodel> comments = tweet.comments
                          .reversed.toList();
                      int id = comments[index].userid;
                      if (comments != null) {
                        return FutureBuilder(
                          future: Provider.of<tweetsProvider>(context).fetchAccuontById(id.toString()),
                          builder: (context, snapchot) {
                            UserModel userData = snapchot.data;
                            return Container(
                              height: 90,
                              child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, indexd) {
                                    return CommentsCard(context,
                                        comments[index], userData);
                                  },),
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
          ),
        ),
        floatingActionButton:
        FloatingActionButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) =>
                  CreateCommentPage(tweet.id.toString())));
        },
          child: Icon(Icons.comment),
        ),


      ),
    );
  }
  Widget CommentsCard(BuildContext context,Commentmodel comment, UserModel user) {
    return Card(
      child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        image: (user.image != null) ? NetworkImage(
                          main_URL + user.image,) : AssetImage(
                            'images/null.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    user.fullname,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainDarkBluColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.75,
                    child: Text(
                      comment.content,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: mainblackColor),
                    ),
                  ),
                ),
              ],
            ),
          ]
      ),
    );
  }

}
