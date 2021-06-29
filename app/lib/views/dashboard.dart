import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/appbar.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: DefaultAppBar(
          title: 'GOLFCADDIE',
          person: true,
          back: true,
        ),
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
                    text: "SCORE TOEVOEGEN", icon: Icons.add, routeTo: 'login'),
                BtnWidget(
                    text: "SCORES BEKIJKEN",
                    icon: Icons.golf_course_sharp,
                    routeTo: 'login'),
                BtnWidget(
                    text: "BAAN OPZOEKEN",
                    icon: Icons.track_changes,
                    routeTo: 'login')
              ],
            ),
          ),
        ));
  }
}
