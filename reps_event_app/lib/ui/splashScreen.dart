import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reps_event_app/ui/homePage.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    startTimerForSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/img/reps_logo.svg',
              semanticsLabel: 'Reps Logo')),
    );
  }

  //set timer for splash Screen
  startTimerForSplashScreen() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationToHomePage);
  }

  navigationToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
