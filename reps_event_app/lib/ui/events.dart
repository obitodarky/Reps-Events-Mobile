import "package:flutter/material.dart";
import 'package:reps_event_app/api/reps_event_api.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  Future<dynamic> _future;

  @override
  void initState() {
    _future = fetchEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: getEventsList(),
    );
  }

  getList({String listTitle}) {
    return ListTile(
      title: Text(listTitle),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  fetchEvent() async {
    print("FETCH CALLED");
    String dateTime = DateTime.now().toIso8601String().substring(0, 10);
    print(dateTime);
    var response = await fetchEvents(dateTime);
    return response['objects'];
  }

  getEventsList() {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  print(snapshot.data[index]['owner_name']);
                  return Card(
                      child: ListTile(
                    title: Text(snapshot.data[index]['name'],maxLines: 1,overflow: TextOverflow.ellipsis,),
                    subtitle: Text(snapshot.data[index]['local_start']
                        .toString()
                        .substring(0, 10)),
                    trailing: IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          getDialogForDescription(snapshot.data[index]['name'],
                          snapshot.data[index]['description']);
                        }),
                  ));
                });
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
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
}
