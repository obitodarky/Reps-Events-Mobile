import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reps_event_app/ui/events.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
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
              height: animation.value * 1.5,
              width: animation.value,
              semanticsLabel: 'Reps Logo')),
    );
  }

  startTimerForSplashScreen() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationToHomePage);
  }

  navigationToHomePage() {
    Navigator.pushReplacementNamed(
        context, 'events_page');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
