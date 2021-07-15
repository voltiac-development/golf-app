import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_golf/components/appbar.dart';
import 'package:flutter_golf/components/startScore/holeContainer.dart';
import 'package:flutter_golf/models/CourseInformation.dart';
import 'package:flutter_golf/models/Friend.dart';

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

  List<Friend?> players = [null, null, null];

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
                                  // do other stuff with _category
                                  print(newValue);
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
                  setState(() {
                    _toggle = !_toggle;
                  });
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
                    Text(
                      'mede spelers',
                      style: annotation,
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: IconButton(
                              icon: Icon(
                                Icons.looks_one_outlined,
                                size: 30,
                                color: this.players[0] == null
                                    ? Theme.of(context).colorScheme.surface
                                    : Colors.greenAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  this.players[0] = new Friend(
                                      'Bart Vermeulen', 29.9, 'f', 'image');
                                });
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: IconButton(
                              icon: Icon(
                                Icons.looks_two_outlined,
                                size: 30,
                                color: this.players[1] == null
                                    ? Theme.of(context).colorScheme.surface
                                    : Colors.greenAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  this.players[1] = new Friend(
                                      'Bart Vermeulen', 29.9, 'f', 'image');
                                });
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: IconButton(
                              icon: Icon(
                                Icons.looks_3_outlined,
                                size: 30,
                                color: this.players[2] == null
                                    ? Theme.of(context).colorScheme.surface
                                    : Colors.greenAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  this.players[2] = new Friend(
                                      'Bart Vermeulen', 29.9, 'f', 'image');
                                });
                              },
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    Text(
                      'jouw teebox',
                      style: annotation,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: IconButton(
                                icon: Icon(Icons.sports_golf,
                                    size: 30, color: Colors.grey[300]),
                                onPressed: () {},
                              )),
                          Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: IconButton(
                                icon: Icon(Icons.sports_golf,
                                    size: 30, color: Colors.lightBlue),
                                onPressed: () {},
                              )),
                          Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: IconButton(
                                icon: Icon(Icons.sports_golf,
                                    size: 30, color: Colors.yellow),
                                onPressed: () {},
                              )),
                          Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: IconButton(
                                icon: Icon(Icons.sports_golf,
                                    size: 30, color: Colors.red),
                                onPressed: () {},
                              )),
                          Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: IconButton(
                                icon: Icon(Icons.sports_golf,
                                    size: 30, color: Colors.orange),
                                onPressed: () {},
                              )),
                        ],
                      ),
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
                          HoleCard(
                            title: '1 - 9',
                            onTap: (value) => print(value),
                          ),
                          HoleCard(
                            title: '10 - 18',
                            onTap: (value) => print(value),
                          ),
                          HoleCard(
                            title: '1 - 18',
                            onTap: (value) => print(value),
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void retrieveCourses() {
    http.get(Uri.parse(AppUtils.apiUrl + "course/all")).then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        this.favCourse = response['courses'][0]['id'];
        setState(() {
          this.courses = response['courses'];
        });
      }
    });
  }

  void retrieveCourseInfo() {}
}
