import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:reps_event_app/models/reps_model.dart';
import 'package:reps_event_app/api/reps_rep_api.dart';
import 'package:reps_event_app/models/themeMode.dart';
import 'package:reps_event_app/ui/customAppBar.dart';
import 'package:reps_event_app/ui/repsDetails.dart';
import 'package:reps_event_app/utils.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'lazy_image.dart';

class Reps extends StatefulWidget {
  @override
  _RepsState createState() => _RepsState();
}

class _RepsState extends State<Reps> {
  Future<List<RepsModel>> _future;
  TextEditingController _searchController = TextEditingController();
  Color color;
  AppTheme appTheme;

  @override
  void initState() {
    _future = fetchRepsList();
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomAppBar(
            appBarTitle: Utils.reps_page,
            widget: getSearchBar(),
          ),
          Expanded(child: getRepsList())
        ],
      ),
    );
  }

  Future<List<RepsModel>> fetchRepsList() async {
    print("FETCH CALLED");
    List<RepsModel> reps = [];
    var response = await fetchReps().catchError((e) {
      print(e);
    });
    response['objects'].forEach((jsonObject) {
      reps.add(RepsModel.fromJson(jsonObject));
    });
    return reps;
  }

  getRepsList() {
    return FutureBuilder<List<RepsModel>>(
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
                      ;
                      return getRepsTile(snapshot, index);
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

  getRepsTile(AsyncSnapshot<List<RepsModel>> snapshot, int index) {
    return snapshot.data[index].fullname
            .contains(RegExp(_searchController.text, caseSensitive: false))
        ? appTheme.getTheme()
            ? Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color(0xFF212121),
                  )
                ]),
                child: Card(
                    color: Color(0xFF30302f),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(50.0),
                        child: LazyImage(
                          imageUrl: snapshot.data[index].avatar_url,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, RepsDetails.route,
                            arguments: snapshot.data[index]);
                      },
                      title: Text(
                        snapshot.data[index].fullname,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: Utils.zilla_slab, fontSize: 18.0),
                      ),
                      subtitle: Text(snapshot.data[index].country ?? "",
                          style: TextStyle(fontFamily: Utils.zilla_slab)),
                    )),
              )
            : Card(
                child: ListTile(
                contentPadding: EdgeInsets.all(8.0),
                leading: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(50.0),
                  child: LazyImage(
                    imageUrl: snapshot.data[index].avatar_url,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, RepsDetails.route,
                      arguments: snapshot.data[index]);
                },
                title: Text(
                  snapshot.data[index].fullname,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontFamily: Utils.zilla_slab, fontSize: 18.0),
                ),
                subtitle: Text(snapshot.data[index].country ?? "",
                    style: TextStyle(fontFamily: Utils.zilla_slab)),
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
    color = Theme.of(context).primaryColor;
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
            hintText: Utils.search_reps_label,
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
