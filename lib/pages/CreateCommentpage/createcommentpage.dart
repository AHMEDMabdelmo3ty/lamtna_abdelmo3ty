import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamtna/api/provider/tweetsprovider.dart';
import 'package:lamtna/control/navegtioncontrolpage.dart';
import 'package:lamtna/main.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateCommentPage extends StatefulWidget {
  String idpost;

  CreateCommentPage(this.idpost);

  @override
  _CreateCommentPageState createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {
  // ignore: non_constant_identifier_names
  TextEditingController _CommentTextEditingController = TextEditingController();
  File _image;
  final piker = ImagePicker();
  String myId =prefs.getString("myId");


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
    _CommentTextEditingController.dispose();
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
                                  "https://image.shutterstock.com/image-illustration/illustration-international-passengers-infrared-thermal-600w-1640970700.jpg",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 150,
                      child: TextFormField(
                        maxLines: 5,
                        maxLength: 100,
                        controller: _CommentTextEditingController,
                        decoration: InputDecoration(
                          hintText: ' write the comment',
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: mainlightBluColor),
                  child: FlatButton(
                    onPressed: () async {
                      Provider.of<tweetsProvider>(context,listen: false).makeComment(context,widget.idpost,_CommentTextEditingController.text);


                    },

                    child: Text(
                      "comment",
                      style:
                      TextStyle(color: mainwhiteColor, fontSize: 18),
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
