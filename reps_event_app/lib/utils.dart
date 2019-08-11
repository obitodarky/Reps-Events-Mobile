import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  //api
  static const events_api =
      "https://reps.mozilla.org/api/v1/event/?offset=0&limit=0&start__gte=";
  static const reps_api =
      "https://reps.mozilla.org/api/v1/rep/?offset=0&limit=0";
  static const Map<String, String> api_headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
  static const map_template =
      "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA";
  static const Map<String, String> map_additional_options = {
    'accessToken':
        'pk.eyJ1IjoiaGFyc2hpbDE3MTIiLCJhIjoiY2p5OXc3Z3JjMDgwejNubzZha3k4NXB3diJ9.ikSwHl-Zy36j034UFUNSIA',
    'id': 'mapbox.streets',
  };

  //Maintain the strings in alphabetic order

  //AppBar Title
  static const String about_page = "About";
  static const String dark_mode_option = "Dark Mode";
  static const String events_page = "Events";
  static const String drawer_people_item = "People";
  static const String rep_details_page = "Rep Details";
  static const String reps_page = "Reps";

  //UI strings
  static const String about_info =
      " The Mozilla Reps program aims to empower and support volunteer Mozillians who want to become official representatives of Mozilla in their region/locale";
  static const String city_label = "City";
  static const String country_label = "Country";
  static const String end_date_label = "End Date";
  static const String functional_areas_label = "Functional Areas";
  static const String name_label = "Name";
  static const String start_date_label = "Start Label";
  static const String search_events_label = "Search By City";
  static const String search_reps_label = "Search By Name";
  static const String venue_label = "Venue";

  //shared preference
  static SharedPreferences sharedPreferences;
  static const String darkThemePref = "darkTheme";

  //font-family
  static const String zilla_slab = "Zilla Slab";

  //images
  static const no_results_gif = "assets/img/no_results_found.gif";
  static const map_marker = 'assets/img/map-marker.svg';
  static const loading_gif = "assets/img/preloader.gif";
  static const reps_mozilla_logo = 'assets/img/reps_logo.svg';
  static const reps_logo = 'assets/img/reps.jpg';

  //routes
  static const events_page_route = "events_page";
  static const reps_page_route = "reps_page";
  static const about_page_route = "about_page";
}
