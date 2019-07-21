import "package:flutter/material.dart";
import 'package:reps_event_app/api/reps_event_api.dart';
import 'package:reps_event_app/ui/about.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<dynamic> _future;
  TextEditingController _searchController = TextEditingController();
  String dateTime;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFd73332),
        title: Text("Reps Events Mobile"),
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
            getList(listTitle: "About"),
            getList(listTitle: "Events"),
            getList(listTitle: "People")
          ],
        ),
      ),
      body: Column(
        children: <Widget>[getSearchBar(), Expanded(child: getEventsList())],
      ),
    );
  }

  getList({String listTitle} ) {
    return ListTile(
      title: Text(listTitle),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => About()
        ));
      },
    );
  }

  fetchEvent() async {
    print("FETCH CALLED");
    print(dateTime);
    var response =
        await fetchEvents(date: dateTime, cityName: _searchController.text);
    return response['objects'];
  }

  getEventsList() {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            print(snapshot.data.isEmpty);
            return snapshot.data.isEmpty
                ? Container(
                    child: Center(
                      child: Image.asset('assets/img/no_results_found.gif'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data[index]['owner_name']);
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
      title: Text(
        snapshot.data[index]['name'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle:
          Text(snapshot.data[index]['local_start'].toString().substring(0, 10)),
      trailing: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            getDialogForDescription(snapshot.data[index]['name'],
                snapshot.data[index]['description']);
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
    return Container(
      margin: EdgeInsets.all(8),
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
            color: Colors.red,
          ),
          hintText: "Search By City",
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
