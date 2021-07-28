import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/appbar.dart';

class DashboardScreen extends StatelessWidget {
  final ButtonStyle style = OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      backgroundColor: Color(0xFF9CCD6C),
      primary: Colors.white,
      fixedSize: Size(250, 10),
      elevation: 2,
      alignment: Alignment.centerLeft);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: DefaultAppBar(
          title: 'GOLFCADDIE',
          person: true,
          back: false,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BtnWidget(text: "RONDE BEGINNEN", icon: Icons.add, routeTo: 'startRound'),
                BtnWidget(text: "SCORES BEKIJKEN", icon: Icons.golf_course_sharp, routeTo: 'allscores'),
                BtnWidget(text: "BAAN OPZOEKEN", icon: Icons.track_changes, routeTo: 'searchcourse'),
                BtnWidget(text: "VRIENDEN", icon: Icons.people_alt_outlined, routeTo: 'friends'),
              ],
            ),
          ),
        ));
  }
}
