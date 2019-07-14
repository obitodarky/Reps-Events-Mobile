import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> fetchEvents(String date) async {
  var _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
  http.Response response = await http.get(
      "https://reps.mozilla.org/api/v1/event/?offset=0&limit=0&start__gte=$date",
      headers: _headers);
  print(response);
  var responseJson = json.decode(response.body);
  print(responseJson);
  return (responseJson);
}
