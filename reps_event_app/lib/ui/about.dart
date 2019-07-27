import "package:flutter/material.dart";

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("About Reps"),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20,),
              Container(
                child: Text(" The Mozilla Reps program aims to empower and support volunteer Mozillians who want to become official representatives of Mozilla in their region/locale.The program provides a framework and a specific set of tools to help Mozillians to organize and/or attend events, recruit and mentor new contributors, document and share activities, and support their local communities better. ", textScaleFactor: 1.5,),
              )
            ],
          ),
        ),
      ),
    );
  }
}