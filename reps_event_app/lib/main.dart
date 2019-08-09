import 'package:flutter/material.dart';
import 'package:reps_event_app/ui/events.dart';
import 'package:reps_event_app/ui/eventsDetails.dart';
import 'package:reps_event_app/ui/splashScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        "events_page":(context)=>Events(),
        EventsDetails.route:(context)=>EventsDetails(ModalRoute.of(context).settings.arguments),
      },
      theme: ThemeData(
        primaryColor: Color(0xFFd73332),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}
