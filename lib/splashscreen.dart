import 'dart:async';
import 'package:app_movie/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashScreenPage extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage>{

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5), navigationPage);
    super.initState();
  }

  void navigationPage(){
    Navigator.of(context).pushReplacementNamed('/HomePage');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 120.0),
              child: Icon(Icons.movie, color: Colors.amberAccent, size: 110,),
            ),

            Container(
              width: 25.0,
              height: 25.0,
              margin: const EdgeInsets.only(top: 310.0),
              child: CircularProgressIndicator(backgroundColor: Colors.amberAccent),
            )
          ],
        ),
      )
    );
  }
}


