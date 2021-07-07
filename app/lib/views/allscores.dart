import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/courseButton.dart';
import '../components/appbar.dart';

class AllScoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            DefaultAppBar(title: 'SCORES BEKIJKEN', person: true, back: true),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
          decoration: BoxDecoration(
              color: Color(0xFFffffff),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BtnWidget(
                    text: "SCORE TOEVOEGEN",
                    icon: Icons.add,
                    routeTo: 'addscore'),
                BtnWidget(
                    text: "SCORES BEKIJKEN",
                    icon: Icons.golf_course_sharp,
                    routeTo: 'allscores'),
                BtnWidget(
                    text: "BAAN OPZOEKEN",
                    icon: Icons.track_changes,
                    routeTo: 'searchcourse')
              ],
            ),
          ),
        ));
  }
}
