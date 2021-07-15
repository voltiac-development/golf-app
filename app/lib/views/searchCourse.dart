import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_golf/components/appbar.dart';
import 'package:flutter_golf/components/courseCard.dart';
import 'package:flutter_golf/models/CourseInformation.dart';

import '../env.dart';

class SearchCourseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchCourseState();
}

class SearchCourseState extends State<SearchCourseScreen> {
  TextEditingController courseController = new TextEditingController();
  List<CourseInfo> courses = [];
  List<CourseInfo> visibleCourses = [];
  SearchCourseState() {
    retrieveCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(title: 'ZOEK BANEN', person: true, back: true),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
            decoration: BoxDecoration(
                color: Color(0xFFffffff),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFffffff),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(
                          width: max(
                              250, MediaQuery.of(context).size.width * 0.50),
                          child: TextField(
                            controller: courseController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Baan',
                              icon: Icon(Icons.track_changes_outlined),
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                            ),
                            onChanged: (value) {
                              this.visibleCourses = [];
                              for (int i = 0; i < this.courses.length; i++) {
                                if (courses[i]
                                    .getName
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  this.visibleCourses.add(courses[i]);
                                }
                              }
                              setState(() {});
                            },
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      ...visibleCourses
                          .map((item) => new CourseCard(info: item))
                          .toList()
                    ],
                  ),
                ),
              ),
            )));
  }

  void retrieveCourses() {
    http.get(Uri.parse(AppUtils.apiUrl + "course/all")).then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        List<dynamic>.from(response['courses']).forEach((e) {
          this.courses.add(
              CourseInfo(e['name'], e['holes'], e['id'], e['image'], [], ''));
        });
        setState(() {
          this.visibleCourses = this.courses;
        });
      }
    });
  }
}
