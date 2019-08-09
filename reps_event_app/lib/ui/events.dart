import "package:flutter/material.dart";
import 'package:reps_event_app/models/events_model.dart';
import 'package:reps_event_app/api/reps_event_api.dart';
import 'package:reps_event_app/ui/customAppBar.dart';
import 'package:reps_event_app/ui/eventsDetails.dart';
import 'package:reps_event_app/ui/about.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<List<EventsModel>> _future;
  TextEditingController _searchController = TextEditingController();
  String dateTime;
  Color color;


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
    color = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text("Reps Events Mobile"),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            DrawerHeader(
              child: Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/img/reps.jpg',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            getList(listTitle: "About", nav: About()),
            getList(listTitle: "People")
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          CustomAppBar(
            appBarTitle: "Events",
            widget: getSearchBar(),
          ),
          Expanded(child: getEventsList())
        ],
      ),
    );
  }

  getList({String listTitle, Object nav}) {
    return ListTile(
      title: Text(listTitle),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => nav));
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
                      child: Image.asset('assets/img/no_results_found.gif'),
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
                child: Image.asset(
                  "assets/img/preloader.gif",
                ),
              ),
            );
          }
        });
  }

  Card getEventTile(AsyncSnapshot snapshot, int index) {
    return Card(
        child: ListTile(
      onTap: () {
        Navigator.pushNamed(context, 'event_details_page',
            arguments: snapshot.data[index]);
      },
      title: Text(
        snapshot.data[index].name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontFamily: 'Zilla Slab', fontSize: 18.0),
      ),
      subtitle:
          Text(snapshot.data[index].local_start.toString().substring(0, 10)),
      trailing: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            getDialogForDescription(
                snapshot.data[index].name, snapshot.data[index].description);
          }),
    ));
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
              _future = null;
              _searchController.text = value;
              _future = fetchEvent();
            });
            print(_searchController.text);
          }),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: color,
            ),
            hintText: "Search By City",
            hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Zilla Slab'),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color:color, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:color, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
