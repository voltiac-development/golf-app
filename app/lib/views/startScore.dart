import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_golf/components/appbar.dart';
import 'package:flutter_golf/models/CourseInformation.dart';

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
                child: DropdownButtonFormField(
                  isDense: true,
                  items: courses.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value['id'],
                      child: Text(
                        value['name'],
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    // do other stuff with _category
                    print(newValue);
                  },
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
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Text(
              'mede spelers',
              style: annotation,
            )
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
}
