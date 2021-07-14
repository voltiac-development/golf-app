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
        title: "RONDE BEGINNEN",
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xFFffffff),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
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
