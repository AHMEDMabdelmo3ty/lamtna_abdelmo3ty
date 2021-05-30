import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamtna/control/navegtioncontrolpage.dart';
import 'package:lamtna/main.dart';
import 'package:lamtna/utilltos/constants.dart';

class CreateTweetPage extends StatefulWidget {
  String muUserImage;

  CreateTweetPage(this.muUserImage);

  @override
  _CreateTweetPageState createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  TextEditingController _tweettextEditingController = TextEditingController();
  File _image;
  String myid =prefs.getString("myid");


  final piker = ImagePicker();

  Future getImage() async {
    final filepiked = await piker.getImage(source: ImageSource.gallery);

    setState(() {
      if (filepiked != null) {
        _image = File(filepiked.path);
      } else {
        print('no select image');
      }
    });
  }

  @override
  void dispose() {
    _tweettextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return NavegtionControlPage(0);
                            }));
                          },
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: mainDarkBluColor, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: mainlightBluColor),
                        child: FlatButton(
                          onPressed: () async {
                            var heder = {
                              "Authorization": "Bearer " + prefs.get("token")
                            };
                            Response response;
                            Dio dio = Dio();

                            response = await dio.post(Tweet_URL,
                                data: await addPostData(
                                    _image, _tweettextEditingController.text),
                                options: Options(headers: heder));
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return NavegtionControlPage(0);
                            }));
                          },
                          child: Text(
                            "Tweet",
                            style:
                                TextStyle(color: mainwhiteColor, fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            image: DecorationImage(
                                image: NetworkImage(
                                  widget.muUserImage,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 250,
                      child: TextFormField(
                        maxLines: 15,
                        controller: _tweettextEditingController,
                        decoration: InputDecoration(
                          hintText: ' what is in your mind ??',
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.images,
                        size: 30,
                        color: mainDarkBluColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "selected image",
                          style:
                              TextStyle(fontSize: 17, color: mainDarkBluColor),
                        ),
                      )
                    ],
                  ),
                ),
                _image == null
                    ? Container(
                        child: Text('data'),
                      )
                    : Card(
                        child: Container(
                            width: 250,
                            height: 250,
                            child: Image.file(
                              _image,
                              fit: BoxFit.cover,
                            )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //addPostData function
  Future<FormData> addPostData(File image, String tweetDescription) async {
    var formData = FormData();
    formData.fields
        .add(MapEntry("data", '{"description":"$tweetDescription","users_permissions_user":"$myid"}'));
    if (_image != null) {
      formData.files.add(MapEntry("files.image",
          await MultipartFile.fromFile(image.path, filename: "lamtna.png")));
    }
    return formData;
  }
}
