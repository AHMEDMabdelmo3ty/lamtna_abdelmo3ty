class MeModel{
  int id ;
  String username ,email,fullname;

  MeModel(this.id, this.username, this.email, this.fullname,);


  MeModel.fromjsen(Map<String,dynamic> map){
    this.id =map["id"];
    this.username =map["username"];
    this.email =map["email"];
    this.fullname =map["fullName"];
  }
}