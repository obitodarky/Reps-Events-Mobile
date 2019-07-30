class RepsModel{
  final String fullname;
  final String city;
  final String country;
  final String avatar_url;
  final String display_name;


  RepsModel({
    this.fullname,
    this.city,
    this.country,
    this.avatar_url,
    this.display_name,

  });

  factory RepsModel.fromJson(Map<String, dynamic> parsedJson){
    print(parsedJson);
    return RepsModel(
        fullname: parsedJson['fullname'],
        city: parsedJson['city'],
        country: parsedJson['country'],
        avatar_url: parsedJson['avatar_url'],
        display_name: parsedJson['display_name'],
    );
  }

}
