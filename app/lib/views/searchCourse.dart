import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/courseCard.dart';
import 'package:golfcaddie/viewmodels/CourseInformation.dart';

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
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(
                          width: max(250, MediaQuery.of(context).size.width * 0.50),
                          child: TextField(
                            controller: courseController,
                            decoration: InputDecoration(
                              hintText: 'Baan',
                              icon: Icon(
                                Icons.track_changes_outlined,
                                color: Colors.black,
                              ),
                              contentPadding: EdgeInsets.all(8),
                              isDense: true,
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            ),
                            onChanged: (value) {
                              this.visibleCourses = [];
                              for (int i = 0; i < this.courses.length; i++) {
                                if (courses[i].getName.toLowerCase().contains(value.toLowerCase())) {
                                  this.visibleCourses.add(courses[i]);
                                }
                              }
                              setState(() {});
                            },
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      ...visibleCourses.map((item) => new CourseCard(info: item)).toList()
                    ],
                  ),
                ),
              ),
            )));
  }

  void retrieveCourses() async {
    Dio dio = await AppUtils.getDio();
    dio.get('/course/all').then((value) {
      List<dynamic>.from(value.data['courses']).forEach((e) {
        this.courses.add(CourseInfo.filled(e['name'], e['holes'], e['id'], e['image'], [], ''));
      });
      setState(() {
        this.visibleCourses = this.courses;
      });
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
}
