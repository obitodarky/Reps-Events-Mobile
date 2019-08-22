import 'package:html_unescape/html_unescape.dart';
var unescape = new HtmlUnescape();
class EventsModel{
  final String name;
  final String city;
  final String country;
  final String description;
  final String end;
  final String event_url;
  final String start;
  final String venue;
  final String local_start;
  final double lat;
  final double lon;


  EventsModel({
    this.name,
    this.city,
    this.country,
    this.description,
    this.end,
    this.event_url,
    this.local_start,
    this.start,
    this.venue,
    this.lat,
    this.lon
  });

  factory EventsModel.fromJson(Map<String, dynamic> parsedJson){
    print(parsedJson);
    return EventsModel(
        name: unescape.convert(parsedJson['name']),
        city: parsedJson['city'],
        country: parsedJson['country'],
        description: unescape.convert(parsedJson['description']),
        end: parsedJson['end'],
        event_url: parsedJson['event_url'],
        start: parsedJson['start'],
        venue: unescape.convert(parsedJson['venue']),
        local_start: parsedJson['local_start'],
        lat: parsedJson['lat'],
        lon: parsedJson['lon']
    );
  }

}

