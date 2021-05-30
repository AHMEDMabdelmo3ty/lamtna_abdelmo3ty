import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key key,
    @required this.color,
    @required this.size,

  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('L',style: TextStyle(fontSize: size,color: color),),
        Icon(FontAwesomeIcons.mediumM,color: color,size: size,),
        Icon(FontAwesomeIcons.tumblr,size: size,color: color,),
        Text('na',style: TextStyle(fontSize: size,color: color),),
        Icon(FontAwesomeIcons.angellist,size: size,color: color,),

      ],
    );
  }
}
