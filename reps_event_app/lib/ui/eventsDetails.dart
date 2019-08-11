import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:reps_event_app/models/events_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reps_event_app/models/themeMode.dart';
import 'package:reps_event_app/utils.dart';

class EventsDetails extends StatefulWidget {
  final EventsModel events;
  static const String route = "event_details_page";

  EventsDetails(this.events);

  @override
  _EventsDetailsState createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  AppTheme appTheme;

  bodyWidget(BuildContext context) => Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.75,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(widget.events.lat, widget.events.lon),
                  zoom: 13.0,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: Utils.map_template,
                    additionalOptions: Utils.map_additional_options,
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 50.0,
                        height: 50.0,
                        point: LatLng(widget.events.lat, widget.events.lon),
                        builder: (ctx) => Container(
                          child: SvgPicture.asset(
                            Utils.map_marker,
                            height: 0.5,
                            width: 0.5,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          widget.events.description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: Utils.venue_label,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                background: Paint()
                                  ..color = appTheme.getTheme()
                                      ? Theme.of(context).primaryColor
                                      : Colors.red[50],
                                fontSize: 18),
                          ),
                          TextSpan(
                              text: widget.events.venue,
                              style: TextStyle(fontSize: 18))
                        ])),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: Utils.city_label,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = appTheme.getTheme()
                                          ? Theme.of(context).primaryColor
                                          : Colors.red[50],
                                    fontSize: 16),
                              ),
                              TextSpan(
                                  text: widget.events.city,
                                  style: TextStyle(fontSize: 16))
                            ])),
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: Utils.city_label,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = appTheme.getTheme()
                                          ? Theme.of(context).primaryColor
                                          : Colors.red[50]),
                              ),
                              TextSpan(text:widget.events.country)
                            ])),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: Utils.start_date_label,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = appTheme.getTheme()
                                          ? Theme.of(context).primaryColor
                                          : Colors.red[50]),
                              ),
                              TextSpan(
                                  text: widget.events.local_start
                                          .toString()
                                          .substring(0, 10))
                            ])),
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: Utils.end_date_label,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = appTheme.getTheme()
                                          ? Theme.of(context).primaryColor
                                          : Colors.red[50]),
                              ),
                              TextSpan(
                                  text: widget.events.end
                                          .toString()
                                          .substring(0, 10))
                            ])),
                          ],
                        ),
                      ],
                    ))),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.events.name),
        ),
        body: bodyWidget(context)
        // bodyWidget(context),
        );
  }
}
