import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamtna/api/model/usermodel.dart';
import 'package:lamtna/control/navegtioncontrolpage.dart';
import 'package:lamtna/main.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/widgets/alertwidget.dart';
import 'package:lamtna/widgets/custaminputTextFialdwidget.dart';

// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  UserModel user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _profileImage;
  File _bannarImage;
  final piker = ImagePicker();
  final pikertwo = ImagePicker();

  final _formKeyFullName = GlobalKey<FormState>();
  final _formKeyUserName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _fullNameTextEditingController =
      TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();



  @override
  void initState() {
    _nameTextEditingController.text=widget.user.username;
    _fullNameTextEditingController.text=widget.user.fullname;
    _emailTextEditingController..text=widget.user.email;
    super.initState();
  }


  Future getImage() async {
    final filepiked = await piker.getImage(source: ImageSource.gallery);

    setState(() {
      if (filepiked != null) {
         _profileImage = File(filepiked.path);
      } else {
        print('no select image');
      }
    });
  }
  Future getImagetwo() async {
    final filepiked = await pikertwo.getImage(source: ImageSource.gallery);

    setState(() {
      if (filepiked != null) {
         _bannarImage = File(filepiked.path);
      } else {
        print('no select image');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [FlatButton(
          child: Icon(Icons.arrow_back_ios),
          onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavegtionControlPage(3)));
        },)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              uploadImage("upload your profile image ",(){
                getImage();
              }, ()async{
                var heder = {"Authorization": "Bearer " + prefs.get("token")};
                Response response;
                Dio dio = Dio();
                response = await dio.post(main_URL+"/upload",
                    data: await addProfileImageData(_profileImage,widget.user.id.toString()),
                options: Options(headers: heder));
                if(response.statusCode==200){
                  Alertwigget.successsystemAlert(context, "done", "تم تغيير الصورة");
                }

              }),


              uploadImage("upload your  banner Image", (){
                getImagetwo();
              }, ()async{
                var heder = {"Authorization": "Bearer " + prefs.get("token")};
              Response response;
              Dio dio = Dio();
              response = await dio.post(main_URL+"/upload/",
                  data: await addBannarImageData(_bannarImage,widget.user.id.toString()),
                  options: Options(headers: heder));
              if(response.statusCode==200){
                Alertwigget.successsystemAlert(context, "done", "تم تغيير الصورة");
              }

              }),

              Column(
                children: [ Text('updata your fullName',style: TextStyle(
                    fontSize: 18,color: mainlightBluColor,fontWeight: FontWeight.bold
                ),),
                  Row(
                    children: [
                      Expanded(
                        child:        custamInputTextFialdWidget(
                            TextHint: 'edit your fullName', obsc: false, controller: _fullNameTextEditingController, formKey: _formKeyFullName),
                      ),
                      FlatButton(onPressed: (){
                        updataUserData(widget.user.id.toString(),"fullName",_fullNameTextEditingController.text);
                      }, child: Text("save"))
                    ],
                  ),
                ],
              ),
              Column(
                children: [ Text('updata your UserName',style: TextStyle(
                    fontSize: 18,color: mainlightBluColor,fontWeight: FontWeight.bold
                ),),
                  Row(
                    children: [
                      Expanded(
                        child: custamInputTextFialdWidget(
                            TextHint: 'edit your @userName', obsc: false, controller: _nameTextEditingController, formKey: _formKeyUserName),
                      ),
                      FlatButton(onPressed: (){
                        updataUserData(widget.user.id.toString(),"username",_nameTextEditingController.text);

                      }, child: Text("save"))
                    ],
                  ),
                ],
              ),
              Column(
                children: [ Text('updata your Email',style: TextStyle(
                    fontSize: 18,color: mainlightBluColor,fontWeight: FontWeight.bold
                ),),
                  Row(
                    children: [
                      Expanded(
                        child:     custamInputTextFialdWidget(
                            TextHint: 'edit your Email', obsc: false, controller: _emailTextEditingController, formKey: _formKeyEmail),
                      ),
                      FlatButton(onPressed: (){
                        updataUserData(widget.user.id.toString(),"email",_emailTextEditingController.text);

                      }, child: Text("save"))
                    ],
                  ),
                ],
              ),

              Column(
                children: [
                  Text('updata your password',style: TextStyle(
                    fontSize: 18,color: mainlightBluColor,fontWeight: FontWeight.bold
                  ),),
                  Row(
                    children: [
                      Expanded(
                        child:     custamInputTextFialdWidget(
                            TextHint: 'edit your password', obsc: false, controller: _passwordTextEditingController, formKey: _formKeyPassword),
                      ),
                      FlatButton(onPressed: (){
                        updataUserData(widget.user.id.toString(),"password",_passwordTextEditingController.text);

                      }, child: Text("save"))
                    ],
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget uploadImage(String titel, Function selectImageOnPressed, Function saveOnPressed,) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titel),
          Row(
            children: [
              FlatButton(
                  onPressed: selectImageOnPressed,
                  child: Icon(
                    Icons.file_upload,
                    size: 25,
                  )),
              FlatButton(onPressed: saveOnPressed, child: Text("save"))
            ],
          ),

        ],
      ),
    );
  }
  updataUserData(String id,String key,String value) async{
    var heder = {"Authorization": "Bearer " + prefs.get("token"),"Accept":"application/json"};
    http.Response response = await http.put(User_URL+id, headers: heder,body: {
      key:value
    });
    if(response.statusCode ==200){
      Alertwigget.AccountsystemAlert(context, "UPDATA", "it\'s ok");
    }


  }
  Future<FormData> addProfileImageData(File image, String userid) async {
    var formData = FormData();
  formData =FormData.fromMap({
    "ref":"User",
    "refId":userid,
    "source":"users-permissions",
    "field":"image"

  });
    if (_profileImage != null) {
      formData.files.add(MapEntry("files", await MultipartFile.fromFile(image.path, filename: "lamtna.png")));
    }
    return formData;
  }
  Future<FormData> addBannarImageData(File image, String userid) async {
    FormData formData = FormData();
  formData = FormData.fromMap({
    "ref":"User",
    "refId":userid,
    "source":"users-permissions",
    "field":"bannar"

  });
    if (_bannarImage != null) {
      formData.files.add(MapEntry("files", await MultipartFile.fromFile(image.path, filename: "lamtna.png")));
    }
    return formData;
  }

}
