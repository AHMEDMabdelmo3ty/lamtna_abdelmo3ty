import 'package:flutter/material.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/api/fetchData.dart';
import 'package:lamtna/widgets/tweetcard.dart';

// ignore: camel_case_types
class searchPage extends StatefulWidget {
  @override
  _searchPageState createState() => _searchPageState();
}

// ignore: camel_case_types
class _searchPageState extends State<searchPage> {
  TextEditingController _searchtextEditingController = TextEditingController();
  String inputvalu = "................................................";
  FetchData _fetchData = FetchData();

  @override
  void dispose() {
    _searchtextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عن ماذا تبحث ؟'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              color: Colors.grey[200],
              child: TextFormField(
                controller: _searchtextEditingController,
                onChanged: (String _searchtextEditingController) {
                  setState(() {
                    inputvalu = _searchtextEditingController;
                  });
                },
                decoration: InputDecoration(
                    hintText: "ابحث عن ما تريد ",
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: mainDarkBluColor,
                    )),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  inputvalu = _searchtextEditingController.text;
                });
              },
              child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: mainlightBluColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child: Text(
                    'بحث',
                    style: TextStyle(fontSize: 25, color: mainwhiteColor),
                  ))),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: FutureBuilder(
                          future: _fetchData.fetchSearchTweet(inputvalu),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.85,
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
                )),

          ],
        ),
      ),
    );
  }
}
