import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reps_event_app/utils.dart';

Future<dynamic> fetchEvents({String date,String cityName}) async {
  var _headers = Utils.api_headers;
  String uri = "${Utils.events_api}$date";
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
