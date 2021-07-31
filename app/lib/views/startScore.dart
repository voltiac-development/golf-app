import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/startScore/coPlayer.dart';
import 'package:golfcaddie/components/startScore/holeContainer.dart';
import 'package:golfcaddie/components/startScore/qualifyingSwitch.dart';
import 'package:golfcaddie/components/startScore/teeBoxes.dart';
import 'package:golfcaddie/models/CourseInformation.dart';
import 'package:golfcaddie/models/Friend.dart';

import 'package:dio/dio.dart';
import '../env.dart';

class StartScoreScreen extends StatefulWidget {
  StartScoreScreen({Key? key}) : super(key: key);

  @override
  _StartScoreScreenState createState() => _StartScoreScreenState();
}

class _StartScoreScreenState extends State<StartScoreScreen> {
  TextEditingController courseController = new TextEditingController();
  List<dynamic> courses = [];
  List<dynamic> visibleCourses = [];
  bool _toggle = false;
  List<dynamic> availableHoleTypes = [];
  CourseInfo chosenCourse = new CourseInfo('name', 0, '', '', [], '');
  int chosenTee = -1;
  String chosenHoleType = "";
  bool called = false;

  List<Friend?> players = [null, null, null];
  List<int> tees = [-1, -1, -1];
  bool qualifying = false;

  final TextStyle annotation = TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w100);

  @override
  Widget build(BuildContext context) {
    if (!this.called) retrieveCourses();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: DefaultAppBar(
        back: true,
        person: true,
        title: "SPEL BEGINNEN",
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
                width: MediaQuery.of(context).size.width,
              ),
              AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: _toggle ? 0.5 : 1.0,
                  child: Column(
                    children: [
                      Text(
                        'golfbaan',
                        textAlign: TextAlign.left,
                        style: annotation,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      SizedBox(
                        width: max(250, MediaQuery.of(context).size.width * 0.50),
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: courseController,
                              decoration: InputDecoration(
                                isDense: true,
                                focusColor: Theme.of(context).primaryColor,
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1)),
                                filled: false,
                              ),
                              style: TextStyle(color: Colors.black)),
                          suggestionsCallback: (pattern) async {
                            return filterSearch(pattern);
                          },
                          noItemsFoundBuilder: (context) => Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Er zijn geen banen beschikbaar.',
                            ),
                          ),
                          itemBuilder: (context, suggestion) {
                            CourseInfo u = suggestion as CourseInfo;
                            return ListTile(
                              dense: true,
                              title: Text(u.name),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            this.courseController.text = (suggestion as CourseInfo).name;
                            this.chosenCourse = suggestion;
                          },
                        ),
                      ),
                    ],
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: _toggle ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {
                          _toggle = !_toggle;
                          retrieveCourseInfo();
                        }));
                  },
                  child: Text(_toggle ? 'Terug' : 'Kies baan')),
              AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: _toggle ? 1.0 : 0.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      CoPlayer(
                        tees: this.chosenCourse.teeBoxes,
                        callback: (f) {
                          this.players = f[0] as List<Friend?>;
                          this.tees = f[1] as List<int>;
                          print(f);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      Text(
                        'jouw teebox',
                        style: annotation,
                      ),
                      Teeboxes(
                        tees: this.chosenCourse.teeBoxes,
                        chosenIndex: this.chosenTee,
                        highlight: Colors.black,
                        hide: Colors.white,
                        onTap: (v) {
                          setState(() {
                            this.chosenTee = v;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      Text(
                        'holes',
                        style: annotation,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (var hole in this.chosenCourse.roundTypes)
                              HoleCard(
                                title: hole['roundVariation'],
                                onTap: (value) {
                                  setState(() {
                                    this.chosenHoleType = hole['roundTypeId'];
                                  });
                                },
                                isSelected: this.chosenHoleType == hole['roundTypeId'],
                              )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text('qualifying'),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      QualifyingSwitch(
                        state: this.qualifying,
                        stateChanged: (value) => setState(() {
                          this.qualifying = value;
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.secondary),
                          onPressed: () => startGame(),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text('Spel beginnen'),
                          ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void retrieveCourses() async {
    Dio dio = await AppUtils.getDio();
    dio.get("/course/all").then((value) {
      dynamic c = value.data['courses'][0];
      this.chosenCourse = new CourseInfo(c['name'], c['holes'], c['id'], c['image'], c['roundTypes'], c['teeboxes']);
      this.courses = value.data['courses'];
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.response.data['error'],
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    });
    this.called = true;
    setState(() {});
  }

  void retrieveCourseInfo() {
    dynamic course = this.courses.firstWhere((element) => element['id'] == this.chosenCourse.id);
    CourseInfo c = new CourseInfo(course['name'], course['holes'], course['id'], course['image'], course['roundTypes'], course['teeboxes']);
    setState(() {
      this.chosenCourse = c;
    });
  }

  void startGame() async {
    Dio dio = await AppUtils.getDio();
    if (this.tees.length == 3)
      this.tees.insert(0, this.chosenTee);
    else
      this.tees[0] = this.chosenTee;
    List<String?> players = this.players.map((e) => e != null ? e.id : null).toList();
    if (players.length == 0) this.qualifying = false;

    dio.post("/round/start",
        data: {'courseId': this.chosenCourse.id, 'tees': this.tees, 'players': players, 'holeType': this.chosenHoleType, 'qualifying': this.qualifying}).then((value) {
      print(value.data['msg']);
      Navigator.of(context).pushReplacementNamed('roundinfo', arguments: value.data['msg']);
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.response.data['error'],
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    });
  }

  List<CourseInfo> filterSearch(String pattern) {
    List<CourseInfo> returnedCourses = [];
    this.courses.forEach((element) {
      if ((element['name'] as String).toLowerCase().contains(pattern.toLowerCase()))
        returnedCourses.add(CourseInfo(element['name'], element['holes'], element['id'], element['image'], [], element['teeboxes']));
    });
    return returnedCourses;
  }
}
