import "package:flutter/material.dart";
import 'package:reps_event_app/models/reps_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reps_event_app/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class RepsDetails extends StatefulWidget {
  final RepsModel reps;
  static String route = "rep_details";

  RepsDetails(this.reps);

  @override
  _RepsDetailsState createState() => _RepsDetailsState();
}

class _RepsDetailsState extends State<RepsDetails> {
  bodyWidget(BuildContext context) => Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            //*************************************************************
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.network(widget.reps.avatar_url, scale: 0.6)),
                SizedBox(height: 8),
                titleText(widget.reps.display_name)
              ],
            ),

            getPadding(),

            //******************************************************

            getContent(Utils.name_label, widget.reps.fullname),

            //*******************************************************

            getPadding(),

            //******************************************************

            getContent(Utils.city_label, widget.reps.city),

            //*******************************************************

            getPadding(),

            //******************************************************

            getContent(Utils.country_label, widget.reps.country),

            //*******************************************************

            getPadding(),

            //******************************************************

            ExpansionTile(
              title: Text(Utils.functional_areas_label,
                  style: TextStyle(fontSize: 18, fontFamily: Utils.zilla_slab)),
              children: widget.reps.functional_areas.map((function_area) {
                return Card(
                  child: ListTile(
                    title: Text(function_area['name'],
                        style: TextStyle(fontFamily: Utils.zilla_slab)),
                  ),
                );
              }).toList(),
            ),

            getPadding(),

            //******************************************************

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(FontAwesomeIcons.facebook),
                    onPressed: () {
                      _launchURL(widget.reps.facebook_url);
                    }),
                SizedBox(
                  width: 16,
                ),
                IconButton(
                    icon: Icon(FontAwesomeIcons.twitter),
                    onPressed: () {
                      _launchURL(
                          "https://twitter.com/${widget.reps.twitter_account}");
                    })
              ],
            )
          ],
        ),
      );

  Padding getContent(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleText(title),
          SizedBox(height: 4.0),
          textContent(content),
        ],
      ),
    );
  }

  Padding getPadding() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16));
  }

  Text textContent(String string) {
    return Text(
      string,
      style: TextStyle(fontSize: 18, fontFamily: Utils.zilla_slab),
    );
  }

  Text titleText(String title) {
    return Text(title,
        style: TextStyle(fontSize: 14, fontFamily: Utils.zilla_slab));
  }

  @override
  void initState() {
    print(widget.reps.functional_areas);
    print(widget.reps.facebook_url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Utils.rep_details_page),
        ),
        body: bodyWidget(context)
        // bodyWidget(context),
        );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
