import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reps_event_app/models/themeMode.dart';
import 'package:reps_event_app/ui/about.dart';
import 'package:reps_event_app/ui/events.dart';
import 'package:reps_event_app/ui/eventsDetails.dart';
import 'package:reps_event_app/ui/reps.dart';
import 'package:reps_event_app/ui/repsDetails.dart';
import 'package:reps_event_app/ui/splashScreen.dart';
import 'package:reps_event_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Utils.sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkTheme;
  @override
  void initState() {
    darkTheme = Utils.sharedPreferences.getBool(Utils.darkThemePref) ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppTheme>(
      builder: (_) => AppTheme(darkTheme),
      child: RepsApp(),
    );
  }
}

class RepsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      routes: {
        Utils.events_page_route: (context) => Events(),
        EventsDetails.route: (context) =>
            EventsDetails(ModalRoute.of(context).settings.arguments),
        Utils.reps_page_route: (context) => Reps(),
        RepsDetails.route: (context) =>
            RepsDetails(ModalRoute.of(context).settings.arguments),
        Utils.about_page_route: (context) => About(),
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
