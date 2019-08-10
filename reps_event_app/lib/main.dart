import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reps_event_app/models/themeMode.dart';
import 'package:reps_event_app/ui/about.dart';
import 'package:reps_event_app/ui/events.dart';
import 'package:reps_event_app/ui/eventsDetails.dart';
import 'package:reps_event_app/ui/reps.dart';
import 'package:reps_event_app/ui/repsDetails.dart';
import 'package:reps_event_app/ui/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppTheme>(
      builder: (_) => AppTheme(false),
      child: RepsApp(),
    );
  }
}

class RepsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    return MaterialApp(
      routes: {
        "events_page": (context) => Events(),
        EventsDetails.route: (context) =>
            EventsDetails(ModalRoute.of(context).settings.arguments),
        "reps_page": (context) => Reps(),
        RepsDetails.route: (context) =>
            RepsDetails(ModalRoute.of(context).settings.arguments),
        "about_page": (context) => About(),
      },
      theme: ThemeData(
        primaryColor: Color(0xFFE53935),
        brightness: appTheme.getTheme() ? Brightness.dark : Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}
