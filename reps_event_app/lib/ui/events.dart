import 'package:flare_flutter/flare_actor.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:reps_event_app/models/events_model.dart';
import 'package:reps_event_app/api/reps_event_api.dart';
import 'package:reps_event_app/models/themeMode.dart';
import 'package:reps_event_app/ui/about.dart';
import 'package:reps_event_app/ui/customAppBar.dart';
import 'package:reps_event_app/ui/eventsDetails.dart';
import 'package:reps_event_app/ui/reps.dart';
import 'package:reps_event_app/utils.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<List<EventsModel>> _future;
  TextEditingController _searchController = TextEditingController();
  String dateTime;
  Color color;
  AppTheme appTheme;

  @override
  void initState() {
    dateTime = DateTime.now().toIso8601String().substring(0, 10);
    _future = fetchEvent();
    _searchController.addListener(() {
      final text = _searchController.text;
      _searchController.value = _searchController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    color = Theme.of(context).primaryColor;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        /*
        backgroundColor: Colors.white,*/
        appBar: AppBar(
          title: Text("Reps Events Mobile",
              style: TextStyle(fontFamily: "Zilla Slab", fontSize: 25.0)),
          elevation: 0,
          actions: <Widget>[
            IconButton(icon: Icon(IconData(0xe900, fontFamily: "Moon")), onPressed: (){
              bool value = Utils.sharedPreferences.getBool(Utils.darkThemePref)??false;
              Utils.sharedPreferences.setBool(Utils.darkThemePref, !value);
              appTheme.updateAppTheme(!value);
            },)
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                child: Text("Events",
                    style: TextStyle(fontSize: 20.0, fontFamily: "Zilla Slab")),
              ),
              Tab(
                child: Text("People",
                    style: TextStyle(fontSize: 20.0, fontFamily: "Zilla Slab")),
              ),
              Tab(
                child: Text("About",
                    style: TextStyle(fontSize: 20.0, fontFamily: "Zilla Slab")),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Column(
              children: <Widget>[
                CustomAppBar(
                  appBarTitle: Utils.events_page,
                  widget: getSearchBar(),
                ),
                Expanded(child: getEventsList())
              ],
            ),
            Reps(),
            About(),
          ],
        ),
      ),
    );
  }

  getList({String listTitle, String nav}) {
    return ListTile(
      title: Text(listTitle),
      onTap: () {
        Navigator.pushNamed(context, nav);
      },
    );
  }

  Future<List<EventsModel>> fetchEvent() async {
    print("FETCH CALLED");
    List<EventsModel> events = [];
    print(dateTime);
    var response =
        await fetchEvents(date: dateTime, cityName: _searchController.text)
            .catchError((e) {
      print(e);
    });
    response['objects'].forEach((jsonObject) {
      events.add(EventsModel.fromJson(jsonObject));
    });
    return events;
  }

  getEventsList() {
    return FutureBuilder<List<EventsModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.isEmpty
                ? Container(
                    child: Center(
                      child: Image.asset(Utils.no_results_gif),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return getEventTile(snapshot, index);
                    });
          } else {
            return Container(
              child: Center(
                child: FlareActor(
                  Utils.loading_animation,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "loading",
                ),
              ),
            );
          }
        });
  }

  getEventTile(AsyncSnapshot<List<EventsModel>> snapshot, int index) {
    return snapshot.data[index].city
            .contains(RegExp(_searchController.text, caseSensitive: false))
        ? appTheme.getTheme()
            ? Container(
                child: Card(
                    color: Color(0xFF30302f),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, EventsDetails.route,
                            arguments: snapshot.data[index]);
                      },
                      title: Text(
                        snapshot.data[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: Utils.zilla_slab, fontSize: 18.0),
                      ),
                      subtitle: Text(snapshot.data[index].local_start
                          .toString()
                          .substring(0, 10)),
                      trailing: IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            getDialogForDescription(snapshot.data[index].name,
                                snapshot.data[index].description);
                          }),
                    )),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color(0xFF212121),
                  )
                ]),
              )
            : Card(
                child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, EventsDetails.route,
                      arguments: snapshot.data[index]);
                },
                title: Text(
                  snapshot.data[index].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontFamily: Utils.zilla_slab, fontSize: 18.0),
                ),
                subtitle: Text(snapshot.data[index].local_start
                    .toString()
                    .substring(0, 10)),
                trailing: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      getDialogForDescription(snapshot.data[index].name,
                          snapshot.data[index].description);
                    }),
              ))
        : Container();
  }

  getDialogForDescription(String eventName, String description) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(eventName),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(description),
              )
            ],
          );
        });
  }

  getSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        child: TextField(
          controller: _searchController,
          onChanged: ((value) {
            setState(() {
              _searchController.text = value;
            });
            print(_searchController.text);
          }),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: color,
            ),
            hintText: Utils.search_events_label,
            hintStyle:
                TextStyle(color: Colors.grey, fontFamily: Utils.zilla_slab),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
