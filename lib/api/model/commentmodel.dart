class Commentmodel{
  int id,userid;
  String content;

  Commentmodel(this.id, this.content,this.userid);
  Commentmodel.fromjsen(Map<String,dynamic> map){
    this.id =map["id"];
    this.userid =map["user"];
    this.content =map["content"];
  }
}