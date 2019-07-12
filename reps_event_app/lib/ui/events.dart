import "package:flutter/material.dart";

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd73332),
          title: Text("Reps Events Mobile"),
          
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(5.0),
            children: <Widget>[
              DrawerHeader(
                child: Text("Reps"),

              ),
              ListTile(
                title: Text("About"),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Events"),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("People"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}