import "package:flutter/material.dart";
import 'package:reps_event_app/ui/customAppBar.dart';
import 'package:reps_event_app/utils.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String dateTime;
  double appBarSize;

  @override
  Widget build(BuildContext context) {
    appBarSize = MediaQuery.of(context).size.height / 6.5;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          CustomAppBar(appBarTitle: Utils.about_page, appBarSize: appBarSize),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              Utils.about_info,
              style: TextStyle(
                fontSize: 28,
                fontFamily: Utils.zilla_slab,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
