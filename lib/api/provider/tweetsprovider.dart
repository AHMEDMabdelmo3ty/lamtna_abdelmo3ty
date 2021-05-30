import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/main.dart';

import 'package:lamtna/utilltos/constants.dart';

// ignore: camel_case_types
class tweetsProvider with ChangeNotifier{

  var heder = {"Authorization": "Bearer " + prefs.get("token")};

  // ignore: missing_return
  Future<List<TweetModel>> fetchTweet() async {
    http.Response response = await http.get(Tweet_URL, headers: heder);
    if (response.statusCode == 200) {
      var body =jsonDecode(response.body);
      List <TweetModel> tweets =[];
      for (var tweet in body){
        tweets.add(TweetModel.fromjsen(tweet));
      }
      return tweets;

    }
    notifyListeners();

    return null;
  }
  Future makeLike(String id) async {
    http.Response response = await http.post(like_URL,
        headers: heder,
        body: {"tweet": id});

    switch (response.statusCode) {
      case 200:
        {
          print(id);

          http.Response response = await http.put(
              Tweet_URL+id,
              headers: heder,
              body: {"liked":1.toString()});
          break;
        }

      case 420:
        {
          String idlike = id;
          http.Response response = await http.delete(
              like_URL + idlike,
              headers: heder);
          if (response.statusCode == 200) {
            http.Response response = await http.put(
                Tweet_URL + id,
                headers: heder,
                body: {"liked":0.toString()});


          }

          break;
        }
      default:
        {
          print("object");
          break;
        }
  }
  notifyListeners();
}
  Future makeComment(BuildContext context,String idpost,String commentText) async {
    var heder = {
      "Authorization": "Bearer " + prefs.get("token")
    };

    String commentUrl = Tweet_URL +"$idpost/comment";
    http.Response response = await http.post(commentUrl ,headers: heder,body: {
      "content":commentText
    });
    Navigator.pop(context);

    notifyListeners();
}
  Future <UserModel> fetchAccuontById(String id) async {
    http.Response response = await http.get(User_URL + id, headers: heder);
    if (response.statusCode == 200) {
      var body =jsonDecode(response.body);
      return UserModel.fromjsen(body);
    }
    else{
    }    notifyListeners();

  }

  Future<List<TweetModel>> fetchLoginUserTweet(String id) async {
    http.Response response = await http.get(loginUser_Tweet_URL +id, headers: heder);
    if (response.statusCode == 200) {
      var body =jsonDecode(response.body);
      List <TweetModel> tweets =[];
      for (var tweet in body){
        tweets.add(TweetModel.fromjsen(tweet));
      }      notifyListeners();

      return tweets;

    }
  }






}