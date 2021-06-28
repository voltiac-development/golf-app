import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFffffff)),
          tooltip: 'Terug',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
            child: Text(
          "GOLFCADDIE",
          style:
              TextStyle(fontWeight: FontWeight.w200, color: Color(0xFFffffff)),
        )),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.person_outline, color: Color(0xFFffffff)),
              tooltip: 'Account',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account tonen')));
              },
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
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
    );
  }
}
