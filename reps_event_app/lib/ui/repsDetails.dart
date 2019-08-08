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
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height/2.75,
        ),
        Container(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      widget.reps.fullname,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10,),
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'City',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            background: Paint()
                              ..color = Colors.red[50],
                            fontSize: 18),
                      ),
                      TextSpan(
                          text: "" +
                              widget.reps.fullname,
                          style: TextStyle(fontSize: 18))
                    ])),

                    SizedBox(height: 10,),
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: 'City',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            background: Paint()
                              ..color = Colors.red[50],
                            fontSize: 18),
                      ),
                      TextSpan(
                          text: "Fullname" +
                              widget.reps.fullname,
                          style: TextStyle(fontSize: 18))
                    ])),
                  ],
                ))),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd73332),
          title: Text(widget.reps.fullname),
        ),
        body: bodyWidget(context)
      // bodyWidget(context),
    );
  }
}
