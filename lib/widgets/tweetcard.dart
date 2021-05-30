import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/provider/tweetsprovider.dart';
import 'package:lamtna/main.dart';
import 'package:lamtna/pages/frindpageprofile/frindpageprofile.dart';
import 'package:lamtna/pages/tweetDetailespage/tweetDetailespage.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class TweetCard extends StatelessWidget {

  TweetCard({
    Key key,
    @required this.context,
    @required this.tweet,
  }) : super(key: key);

  final BuildContext context;
  final TweetModel tweet;

  var heder = {"Authorization": "Bearer " + prefs.get("token")};

  @override
  Widget build(BuildContext context) {
    return   Consumer<tweetsProvider>(
      builder: (context,val,child)=> Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
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
                                        image:(tweet.tweetuserimage!=null)?NetworkImage(
                                          main_URL + tweet.tweetuserimage,
                                        ):AssetImage("images/null.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tweet.tweetfullname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: mainDarkBluColor),
                                ),
                                Text(
                                  tweet.tweetusername + " @ ",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.linear_scale)
                        ],
                      ),
                    ],
                  ),

                      //لو البوست لا يحتوى على صوره والمستخدم اراد الذهاب للبوست
                  (tweet.image!=null) ?  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tweet.description,
                      style: TextStyle(fontSize: 19, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ):InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TweetDetailespage(tweet)));
                    },
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                       tweet.description,
                        style: TextStyle(fontSize: 19, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                  ),),


                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TweetDetailespage(tweet)));
                    },
                    child:(tweet.image!=null) ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 250,
                      child:Image.network(
                        "${main_URL + tweet.image}",
                        fit: BoxFit.cover,
                      ),
                    ):Container(height: 2,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10, right: 20, left: 20),
                          child: Text(
                            " like " + tweet.likes.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 20, left: 20),
                        child: Text("${ tweet.comments.length.toString()} comment"
         ,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              onPressed: () async {
                                Provider.of<tweetsProvider>(context,listen: false).makeLike(tweet.id.toString());

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (tweet.liked != "0")
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.blue,
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text('like'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                      child: Text('comment',style: TextStyle(fontSize: 11),)),
                                  (  tweet.comments.length==0)?Icon(
                                    FontAwesomeIcons.comment,
                                    color: Colors.grey):Icon(
                                  FontAwesomeIcons.comment,
                                  color: Colors.blue
                                  ),
                                ],
                              ),
                            ),
                          ),
                                ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
