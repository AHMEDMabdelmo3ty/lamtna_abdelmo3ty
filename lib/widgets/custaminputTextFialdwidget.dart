import 'package:flutter/material.dart';
// input field



// ignore: camel_case_types
class custamInputTextFialdWidget extends StatelessWidget {

  const custamInputTextFialdWidget({
    Key key,
    // ignore: non_constant_identifier_names
    @required this.TextHint,
    @required this.obsc,
    @required this.controller,
    @required this.formKey,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  final String TextHint;
  final bool obsc;
  final GlobalKey formKey;
  final TextEditingController controller;



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          controller: controller,
          obscureText: obsc,
          decoration: InputDecoration(
              hintText: TextHint
          ),
        ),
      ),
    );
  }
}
