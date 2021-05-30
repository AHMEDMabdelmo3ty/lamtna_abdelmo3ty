import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lamtna/api/model/memodel.dart';
import 'package:lamtna/api/model/tweetmodel.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/main.dart';
import 'package:lamtna/utilltos/constants.dart';





class FetchData {
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
}
  // ignore: missing_return
  Future<List<TweetModel>> fetchLoginUserTweet(String id) async {
    http.Response response = await http.get(loginUser_Tweet_URL +id, headers: heder);
    if (response.statusCode == 200) {
      var body =jsonDecode(response.body);
      List <TweetModel> tweets =[];
      for (var tweet in body){
        tweets.add(TweetModel.fromjsen(tweet));
      }
      return tweets;

    }
  }

  // ignore: missing_return
  Future<List<TweetModel>> fetchSearchTweet(String searchword) async {
    http.Response response = await http.get(search_URL+searchword, headers: heder);
    if (response.statusCode == 200) {
      var body =jsonDecode(response.body);
      List <TweetModel> tweets =[];
      for (var tweet in body){
        tweets.add(TweetModel.fromjsen(tweet));
      }
      return tweets;

  }
}

// ignore: missing_return
Future <MeModel> fetchMyAccuont() async {
    http.Response response = await http.get(MyAccuont_URL, headers: heder);
    if (response.statusCode == 200) {
      var body =jsonDecode(response.body);
      return MeModel.fromjsen(body);
  }

}
// ignore: missing_return
Future <UserModel> fetchAccuontById(String id) async {
    http.Response response = await http.get(User_URL + id, headers: heder);
    if (response.statusCode == 200) {
      var body =jsonDecode(response.body);
      return UserModel.fromjsen(body);
    }
    else{
    }
  }
}
