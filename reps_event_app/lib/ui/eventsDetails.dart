import "package:flutter/material.dart";
import 'package:reps_event_app/models/events_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventsDetails extends StatefulWidget {
  final EventsModel events;

  EventsDetails({this.events});

  @override
  _EventsDetailsState createState() => _EventsDetailsState();
}

class _EventsDetailsState extends State<EventsDetails> {
  bodyWidget(BuildContext context) => Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/2.75,
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(widget.events.lat, widget.events.lon),
                  zoom: 13.0,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: "https://api.tiles.mapbox.com/v4/"
                        "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA',
                      'id': 'mapbox.streets',
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 50.0,
                        height: 50.0,
                        point: LatLng(widget.events.lat, widget.events.lon),
                        builder: (ctx) => Container(
                          child: SvgPicture.asset(
                            'assets/img/map-marker.svg',
                            height: 0.5,
                            width: 0.5,
                            color: Colors.red,
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
                        SizedBox(height: 10,),
                        Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Venue',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = Colors.red[50],
                                      fontSize: 18),
                              ),
                              TextSpan(
                                  text: " " +
                                      widget.events.venue,
                                      style: TextStyle(fontSize: 18))
                            ])),
                            SizedBox(height: 10,),
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'City',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = Colors.red[50],
                                      fontSize: 16),
                              ),
                              TextSpan(
                                  text: " " +
                                      widget.events.city,
                                      style: TextStyle(fontSize: 16))
                            ])),
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Country',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = Colors.red[50]),
                              ),
                              TextSpan(
                                  text: " " +
                                      widget.events.country)
                            ])),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Start Date',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = Colors.red[50]),
                              ),
                              TextSpan(
                                  text: " " +
                                      widget.events.local_start
                                          .toString()
                                          .substring(0, 10))
                            ])),
                            Text.rich(TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'End Date',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    background: Paint()
                                      ..color = Colors.red[50]),
                              ),
                              TextSpan(
                                  text: " " +
                                      widget.events.end.toString().substring(0, 10))
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd73332),
          title: Text(widget.events.name),
        ),
        body: bodyWidget(context)
        // bodyWidget(context),
        );
  }
}
