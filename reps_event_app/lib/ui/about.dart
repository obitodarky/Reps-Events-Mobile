import "package:flutter/material.dart";
import 'package:reps_event_app/ui/customAppBar.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String dateTime;
  String info =
      " The Mozilla Reps program aims to empower and support volunteer Mozillians who want to become official representatives of Mozilla in their region/locale";
  double appBarSize;

  @override
  Widget build(BuildContext context) {
    appBarSize = MediaQuery.of(context).size.height / 6.5;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          CustomAppBar(appBarTitle: "About", appBarSize: appBarSize),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              info,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontSize: 28,
                  fontFamily: 'Zilla Slab',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
