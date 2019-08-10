import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchReps() async {
  var _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
  String uri = "https://reps.mozilla.org/api/v1/rep/?offset=0&limit=0";

  http.Response response = await http.get(
      uri,
      headers: _headers);
  print(response);
  var responseJson = json.decode(response.body);
  print(responseJson);
  return (responseJson);
}
