import 'package:lamtna/api/model/commentmodel.dart';

class TweetModel{
  int id,tweetUserid,likes;
  String description,tweetusername,tweetfullname,tweetuserimage,liked;
  String image;
  List <Commentmodel> comments;

  TweetModel(this.id,this.likes,this.liked, this.description, this.image,this.tweetfullname,this.tweetUserid,this.tweetusername,this.tweetuserimage,this.comments);

  TweetModel.fromjsen(Map<String,dynamic> map){
    this.id =map["id"];
    this.likes =map["likes"];
    this.liked =map["liked"];
    this.tweetUserid =map["users_permissions_user"]["id"];
    this.tweetusername=map["users_permissions_user"]["username"];
    this.tweetfullname=map["users_permissions_user"]["fullName"];
    this.tweetuserimage=map["users_permissions_user"]["image"]!=null?map["users_permissions_user"]["image"]['url']:null;
    this.description =map["description"];
    this.image =map["image"]!=null?map["image"]['url']:null ;
    _setComment(map["comments"]);
  }
  void _setComment (List <dynamic> jesnComment){
    this.comments =[];
    for (var comment in jesnComment){
      comments.add(Commentmodel.fromjsen(comment));
    }
  }
}