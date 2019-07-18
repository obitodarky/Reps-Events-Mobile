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
  
  EventsModel({
    this.name, 
    this.city,
    this.country, 
    this.description, 
    this.end,
    this.event_url,
    this.local_start,
    this.start, 
    this.venue
  });

  factory EventsModel.fromJson(Map<String, dynamic> parsedJson){
    print(parsedJson);
    return EventsModel(
      name: parsedJson['name'],
      city: parsedJson['city'],
      country: parsedJson['country'],
      description: parsedJson['description'],
      end: parsedJson['end'],
      event_url: parsedJson['event_url'],
      start: parsedJson['start'],
      venue: parsedJson['venue'],
      local_start: parsedJson['local_start']
    );
  }

}

