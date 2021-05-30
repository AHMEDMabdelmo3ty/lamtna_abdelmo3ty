import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Alertwigget{


static AccountsystemAlert(BuildContext context, String titel,String desc){
  Alert(
    context: context,
    type: AlertType.error,
    title: titel,
    desc: desc,
    buttons: [
      DialogButton(
        child: Text(
          "cansel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(90, 221, 191, 1.0),
          Color.fromRGBO(52, 138, 229, 1.0)
        ]),
      )
    ],
  ).show();
}
static successsystemAlert(BuildContext context, String titel,String desc){
  Alert(
    context: context,
    type: AlertType.success,
    title: titel,
    desc: desc,
    buttons: [
      DialogButton(
        child: Text(
          "done",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(90, 221, 191, 1.0),
          Color.fromRGBO(52, 138, 229, 1.0)
        ]),
      )
    ],
  ).show();
}


}