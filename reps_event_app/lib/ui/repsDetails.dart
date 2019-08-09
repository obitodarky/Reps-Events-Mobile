import "package:flutter/material.dart";
import 'package:reps_event_app/models/reps_model.dart';

class RepsDetails extends StatefulWidget {
  final RepsModel reps;

  RepsDetails({this.reps});

  @override
  _RepsDetailsState createState() => _RepsDetailsState();
}

class _RepsDetailsState extends State<RepsDetails> {
  bodyWidget(BuildContext context) => Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(widget.reps.avatar_url, scale: 0.8)),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Name",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      SizedBox(height: 8.0),
                      Text(
                        widget.reps.fullname,
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rep Details"),
        ),
        body: bodyWidget(context)
        // bodyWidget(context),
        );
  }
}
