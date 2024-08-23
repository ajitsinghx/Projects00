import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'MyApp.dart';
// import 'profile_screen.dart';
import'package:med_add/main.dart';



class Androidlarge1Widget extends StatefulWidget {
  @override
  State<Androidlarge1Widget> createState() => _Androidlarge1WidgetState();
}

class _Androidlarge1WidgetState extends State<Androidlarge1Widget> {
          @override
          Widget build(BuildContext context) {
          
            return Scaffold( 
              body: Container(
      width: 422,
      height: 934,
      decoration: BoxDecoration(
          color : Color.fromRGBO(245, 248, 255, 1),
  ),
      child: Stack(
        
        children: <Widget>[
          Positioned(
        top: 215,
        left: 100,
        child: Text("Medicare", textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(108, 66, 72, 1),
        fontFamily: 'JetBrains Mono',
        fontSize: 46,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        // fontWeight: FontWeight.w600,
        height: 1
      ),)
      ),Positioned(
        top: 300,
        left: 100,
        child: Container(
        width: 185,
        height: 168,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(46),
            topRight: Radius.circular(46),
            bottomLeft: Radius.circular(46),
            bottomRight: Radius.circular(46),
          ),
      image : DecorationImage(
          image: AssetImage('images/Image2.png'),
          fit: BoxFit.fitWidth
      ),
  )
      )
      ),
  // Positioned(
  //       // top: 524,
  //       // left: 102,
  //       // child: Transform.rotate(
  //       // angle: -3.1805546814635168e-15 * (math.pi / 180),
  //       // child: Container(
  //       // width: 180,
  //       // height: 80,
  //       // decoration: BoxDecoration(
  //       //   borderRadius : BorderRadius.only(
  //       //     topLeft: Radius.circular(26),
  //       //     topRight: Radius.circular(26),
  //       //     bottomLeft: Radius.circular(26),
  //       //     bottomRight: Radius.circular(26),
        
  //         ),
  //     boxShadow : [BoxShadow(
  //         color: Color.fromRGBO(0, 0, 0, 0.25),
  //         offset: Offset(0,4),
  //         blurRadius: 4
  //     )],
  //     color : Color.fromRGBO(197, 244, 255, 1),
  // )
  //     ),
  //     )
  //     ),
  Positioned(top: 550,left: 150,child: ElevatedButton(onPressed:() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> loading_screen()));
  }, child:  
  
  const Text("Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )
                  ),),),
       
  Positioned(
        top: -110,
        left: 200,
        child: Container(
        width: 300,
        height: 359,
        decoration: BoxDecoration(
          image : DecorationImage(
          image: AssetImage('images/Image21.png'),
          fit: BoxFit.fitWidth
      ),
  )
      )
      ),Positioned(
        top: -85,
        left: -163,
        child: Container(
        width: 297,
        height: 227,
        decoration: BoxDecoration(
          image : DecorationImage(
          image: AssetImage('images/Image22.png'),
          fit: BoxFit.fitWidth
      ),
  )
      )
      ),Positioned(
        top: 606,
        left: 255.946044921875,
        child: Transform.rotate(
        angle: -10.999999416154365 * (math.pi / 180),
        child: Container(
        width: 290,
        height: 267,
        decoration: BoxDecoration(
          image : DecorationImage(
          image: AssetImage('images/Image23.png'),
          fit: BoxFit.fitWidth
      ),
  )
      ),
      )
      ),
        ]
      )
    ));
          }
}