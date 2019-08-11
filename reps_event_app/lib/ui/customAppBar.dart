import 'package:flutter/material.dart';
import 'package:reps_event_app/ui/customerShapeClipper.dart';

class CustomAppBar extends StatefulWidget {
  final String appBarTitle;
  final Widget widget;
  final double appBarSize;

  const CustomAppBar({Key key, this.appBarTitle, this.widget, this.appBarSize})
      : super(key: key);

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
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor /*Colors.redAccent*/
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        height: widget.appBarSize ?? MediaQuery.of(context).size.height / 3.0,
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
            widget.widget ?? Container(),
          ],
        ),
      ),
    );
  }
}
