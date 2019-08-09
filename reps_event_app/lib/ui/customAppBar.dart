import 'package:flutter/material.dart';
import 'package:reps_event_app/ui/customerShapeClipper.dart';

class CustomAppBar extends StatefulWidget {

  final String appBarTitle;
  final Widget widget;

  const CustomAppBar({Key key, this.appBarTitle,this.widget}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomShapeClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFd73332), Colors.redAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        height: MediaQuery
            .of(context)
            .size
            .height / 3.4,
        // margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                widget.appBarTitle,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 48,
                    fontFamily: 'Zilla Slab',
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(height: 16,),
            widget.widget??Container(),
          ],
        ),
      ),
    );
  }
}
