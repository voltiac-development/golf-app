import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/startScore/coPlayer.dart';
import 'package:golfcaddie/components/startScore/holeContainer.dart';
import 'package:golfcaddie/components/startScore/teeBoxes.dart';
import 'package:golfcaddie/models/CourseInformation.dart';
import 'package:golfcaddie/models/Friend.dart';

import 'package:http/http.dart' as http;
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
  String favCourse = "";
  bool _toggle = false;
  List<dynamic> availableHoleTypes = [];
  CourseInfo chosenCourse = new CourseInfo('name', 0, '', '', [], '');
  int chosenTee = -1;
  String chosenHoleType = "";

  List<Friend?> players = [null, null, null];
  List<int> tees = [-1, -1, -1];

  final TextStyle annotation =
      TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w100);

  _StartScoreScreenState() {
    retrieveCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: DefaultAppBar(
        back: true,
        person: true,
        title: "SPEL BEGINNEN",
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xFFffffff),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
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
                        width:
                            max(250, MediaQuery.of(context).size.width * 0.50),
                        child: DropdownButtonFormField(
                          isDense: true,
                          items: courses
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value['id'],
                              child: Text(
                                value['name'],
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          }).toList(),
                          onChanged: !_toggle
                              ? (newValue) {
                                  this.favCourse = newValue.toString();
                                }
                              : null,
                          value: favCourse,
                          decoration: InputDecoration(
                            isDense: true,
                            focusColor: Theme.of(context).primaryColor,
                            contentPadding: EdgeInsets.all(8),
                            icon: Icon(Icons.track_changes),
                            enabledBorder: OutlineInputBorder(),
                            filled: false,
                          ),
                        )),
                  ],
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: _toggle
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  WidgetsBinding.instance!
                      .addPostFrameCallback((_) => setState(() {
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
                                  this.chosenHoleType = value;
                                });
                              },
                              isSelected:
                                  this.chosenHoleType == hole['roundVariation'],
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).colorScheme.secondary),
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
    );
  }

  void retrieveCourses() {
    http.get(Uri.parse(AppUtils.apiUrl + "course/all")).then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        dynamic c = response['courses'][0];
        this.favCourse = c['id'];
        this.chosenCourse = new CourseInfo(c['name'], c['holes'], c['id'],
            c['image'], c['roundTypes'], c['teeboxes']);
        this.courses = response['courses'];
        if (this.mounted) {
          setState(() {});
        }
      }
    });
  }

  void retrieveCourseInfo() {
    dynamic course =
        this.courses.firstWhere((element) => element['id'] == this.favCourse);
    CourseInfo c = new CourseInfo(course['name'], course['holes'], course['id'],
        course['image'], course['roundTypes'], course['teeboxes']);
    setState(() {
      this.chosenCourse = c;
    });
  }

  void startGame() async {
    if (this.tees.length == 3)
      this.tees.insert(0, this.chosenTee);
    else
      this.tees[0] = this.chosenTee;
    List<String> tees = this.tees.map((e) => e.toString()).toList();
    List<String?> players = this.players.map((e) {
      if (e != null)
        return e.id;
      else
        return null;
    }).toList();
    Map<String, String> headers = await AppUtils.getHeaders();
    http.post(Uri.parse(AppUtils.apiUrl + "round/start"),
        headers: headers,
        body: {
          'courseId': this.chosenCourse.id,
          'tees': tees.toString(),
          'players': players.toString(),
          'holeType': this.chosenHoleType
        }).then((value) {
      print(value.body);
    });
  }
}
