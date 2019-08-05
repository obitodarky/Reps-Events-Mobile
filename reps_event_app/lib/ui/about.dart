import "package:flutter/material.dart";


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String dateTime;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffd73332),
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
            getList(listTitle: "About"),
            getList(listTitle: "Events"),
            getList(listTitle: "People")
          ],
        ),
      ),
      body: Column(
        children: <Widget>[getHead(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
            'The Mozilla Reps program aims to empower and support volunteer Mozillians who want to become official representatives of Mozilla in their region/locale.'
                'The program provides a framework and a specific set of tools to help Mozillians to organize and/or attend events, recruit and mentor new contributors, document and share activities, and support their local communities better. ',
            style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 28,
                fontFamily: 'Zilla Slab',
                fontWeight: FontWeight.normal),
            ),

          ),

        ],

      ),
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






  getHead() {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFd73332), Colors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        height: 100,
        width: 500,
        // margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'About',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 48,
                    fontFamily: 'Zilla Slab',
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(height: 16,),

          ]
        ),
      ),
    );
  }

}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width * .5, size.height - 30.0);
    var firstControlpoint = Offset(size.width * 0.25, size.height - 50.0);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 80.0);
    var secondControlPoint = Offset(size.width * .75, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}


