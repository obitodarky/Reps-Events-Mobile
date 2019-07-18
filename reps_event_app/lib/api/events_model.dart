class EventsModel{
  final String name;
  final String city; 
  final String country;
  final String description;
  final String end;
  final String event_url;
  final String start;
  final String venue;
  
  EventsModel({
    this.name, 
    this.city,
    this.country, 
    this.description, 
    this.end, 
    this.event_url, 
    this.start, 
    this.venue
  });

  factory EventsModel.fromJson(Map<String, dynamic> parsedJson ){
    return EventsModel(
      name: parsedJson['name'],
      city: parsedJson['city'],
      country: parsedJson['country'],
      description: parsedJson['description'],
      end: parsedJson['end'],
      event_url: parsedJson['event_url'],
      start: parsedJson['start'],
      venue: parsedJson['venue']

    );
  }

}

