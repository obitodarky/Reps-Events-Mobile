import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> fetchEvents({String date,String cityName}) async {
  var _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
  String uri = "https://reps.mozilla.org/api/v1/event/?offset=0&limit=0&start__gte=$date";
  if(cityName.isNotEmpty){
    uri+="&city=$cityName";
  }
  http.Response response = await http.get(
      uri,
      headers: _headers);
  print(response);
  var responseJson = json.decode(response.body);
  print(responseJson);
  return (responseJson);
}
