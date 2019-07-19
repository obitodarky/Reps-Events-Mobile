import "package:flutter/material.dart";
import 'package:reps_event_app/models/events_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventsDetails extends StatelessWidget {
  final EventsModel events;

  EventsDetails({this.events});
 

  bodyWidget(BuildContext context) => Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: FlutterMap(
      options: MapOptions(
        center: LatLng(events.lat, events.lon),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA",
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA',
            'id': 'mapbox.streets',
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 50.0,
              height: 50.0,
              point: LatLng(events.lat, events.lon),
              builder: (ctx) =>
              Container(
                child: SvgPicture.asset('assets/img/map-marker.svg', height: 0.5, width: 0.5, color: Colors.red,),
              ),
            ),
          ],
        ),
      ],
    ),
            ),
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
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: bodyWidget(context),
      ), 
      // bodyWidget(context),
    );
  }
  // Widget build(BuildContext context) {
  //   return FlutterMap(
  //     options: MapOptions(
  //       center: LatLng(events.lat, events.lon),
  //       zoom: 13.0,
  //     ),
  //     layers: [
  //       new TileLayerOptions(
  //         urlTemplate: "https://api.tiles.mapbox.com/v4/"
  //             "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA",
  //         additionalOptions: {
  //           'accessToken': 'pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA',
  //           'id': 'mapbox.streets',
  //         },
  //       ),
  //       MarkerLayerOptions(
  //         markers: [
  //           Marker(
  //             width: 50.0,
  //             height: 50.0,
  //             point: LatLng(events.lat, events.lon),
  //             builder: (ctx) =>
  //             Container(
  //               child: SvgPicture.asset('assets/img/map-marker.svg', height: 0.5, width: 0.5, color: Colors.red,),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
