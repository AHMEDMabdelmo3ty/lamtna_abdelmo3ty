import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TweetprofileCard extends StatelessWidget {
  const TweetprofileCard({
    Key key,
    @required this.context,
    @required this.tweetdesc,
    @required this.tweetimage,
  }) : super(key: key);

  final BuildContext context;
  final String tweetdesc;
  final String tweetimage;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tweetdesc,
                    style: TextStyle(fontSize: 19, color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 250,
                  child: Image.network(
                    "$tweetimage",

                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('like'),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('comment'),
                                ),
                                Icon(
                                  FontAwesomeIcons.comment,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('share'),
                                Icon(
                                  FontAwesomeIcons.share,
                                  color: Colors.blueAccent,
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
    );
  }
}
