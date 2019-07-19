import "package:flutter/material.dart";
import 'package:reps_event_app/models/events_model.dart';

class EventsDetails extends StatelessWidget {
  final EventsModel events;

  EventsDetails({this.events});
 

  bodyWidget(BuildContext context) => Container(
        child: Column(
          children: <Widget>[
            Text(events.description),
            Text(events.local_start.toString().substring(0, 10)),
            Text(events.end.toString().substring(0, 10)),
            Text(events.venue),
            Text(events.city),
            Text(events.country)
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd73332),
        title: Text(events.name),
      ),
      body: bodyWidget(context),
    );
  }
}
