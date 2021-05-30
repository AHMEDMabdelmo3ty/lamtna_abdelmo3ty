class UserModel{
  int id ;
  String username ,email,fullname,image,bannar;

  UserModel(this.id, this.username, this.email, this.fullname, this.image,
      this.bannar);


  UserModel.fromjsen(Map<String,dynamic> map){
    this.id =map["id"];
    this.username =map["username"];
    this.email =map["email"];
    this.fullname =map["fullName"];
    this.image =map["image"]!=null?map["image"]['url']:null ;
    this.bannar =map["bannar"]!=null?map["bannar"]['url']:null ;
  }
}