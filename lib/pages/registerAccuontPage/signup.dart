import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:lamtna/api/sherdpref.dart';
import 'package:lamtna/control/navegtioncontrolpage.dart';
import 'package:lamtna/pages/login%20page/logpage.dart';
import 'package:lamtna/utilltos/constants.dart';
import 'package:lamtna/widgets/Widget/bezierContainer.dart';
import 'package:lamtna/widgets/alertwidget.dart';
import 'package:lamtna/widgets/logo.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKeyFullName = GlobalKey<FormState>();
  final _formKeyUserName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();


  TextEditingController _nameTextEditingController =TextEditingController();
  TextEditingController _fullNameTextEditingController =TextEditingController();
  TextEditingController _passwordTextEditingController =TextEditingController();
  TextEditingController _emailTextEditingController =TextEditingController();

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _fullNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _emailTextEditingController.dispose();
    super.dispose();
  }
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title ,GlobalKey formKey, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Form( key: formKey,

            child: TextFormField(
              validator:  (valid){
                if(valid.isEmpty){
                  return title+" is requird";
                }
                return null ;
              },
                obscureText: isPassword,
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: (){
        registerAccuont();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }


  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("UserName",_formKeyUserName,_nameTextEditingController,),
        _entryField("fullName",_formKeyFullName,_fullNameTextEditingController),
        _entryField("Email",_formKeyEmail,_emailTextEditingController),
        _entryField("Password", _formKeyPassword,_passwordTextEditingController,isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    Logo(size: 45,color: Colors.blueAccent,),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
  Future registerAccuont() async{
    //create api
    var response= await http.post(register_URL,body:{
      "username": _nameTextEditingController.text,
      "email":_emailTextEditingController.text,
      "password": _passwordTextEditingController.text,
      "fullName": _fullNameTextEditingController.text
    }
    );
    if(_formKeyFullName.currentState.validate()&&_formKeyUserName.currentState.validate()){
      if(response.statusCode ==200){
        print(response.body.toString());
        var body =jsonDecode(response.body);
        SharedPref.savetoken(body["jwt"],body["user"]["id"].toString());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavegtionControlPage(0)));

      }else{

        var body =jsonDecode(response.body);
        print(body["message"][0]["messages"][0]["message"]);
        Alertwigget.AccountsystemAlert(context, "", body["message"][0]["messages"][0]["message"].toString());


      }
    }

  }
}
