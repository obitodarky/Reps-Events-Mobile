class RepsModel {
  final String fullname;
  final String city;
  final String country;
  final String avatar_url;
  final String display_name;
  final String facebook_url;
  final String twitter_account;
  final List<dynamic> functional_areas;

  RepsModel(
      {this.fullname,
      this.city,
      this.country,
      this.avatar_url,
      this.display_name,
      this.facebook_url,
      this.twitter_account,
      this.functional_areas});

  factory RepsModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return RepsModel(
        fullname: parsedJson['fullname'],
        city: parsedJson['profile']['city'],
        country: parsedJson['profile']['country'],
        avatar_url: parsedJson['profile']['avatar_url'],
        display_name: parsedJson['profile']['display_name'],
        facebook_url: parsedJson['profile']['facebook_url'] ?? "",
        twitter_account: parsedJson['profile']["twitter_account"],
        functional_areas: parsedJson['profile']['functional_areas'] ?? []);
  }
}
