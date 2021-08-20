import 'package:flutter/material.dart';
import 'package:golfcaddie/views/courseInformation.dart';
import 'package:golfcaddie/views/friend.dart';
import 'package:golfcaddie/views/liveScore.dart';
import 'package:golfcaddie/views/roundInfo.dart';
import 'package:golfcaddie/views/startScore.dart';
import 'package:golfcaddie/views/test.dart';

//Custom screens
import 'views/login.dart';
import 'views/register.dart';
import 'views/allscores.dart';
import 'views/dashboard.dart';
import 'package:golfcaddie/views/forgot.dart';
import 'package:golfcaddie/views/friends.dart';
import 'package:golfcaddie/views/searchCourse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'golf-app',
      theme: ThemeData(
          colorScheme: ColorScheme(
              secondary: Color(0xFF9CCD6C),
              background: Color(0xFF00B0F0),
              primary: Color(0xFF00B0F0),
              primaryVariant: Color(0xFF00B0F0),
              secondaryVariant: Color(0xFF9CCD6C),
              error: Colors.red,
              onSurface: Colors.white,
              onError: Colors.white,
              onBackground: Colors.white,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              brightness: Brightness.light,
              surface: Color(0xFF115792))),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        'dashboard': (_) => DashboardScreen(),
        'register': (_) => RegisterScreen(),
        'allscores': (_) => RecentScores(),
        'forgotpassword': (_) => ForgotScreen(),
        'searchcourse': (_) => SearchCourseScreen(),
        'friends': (_) => FriendsScreen(),
        'startRound': (_) => StartScoreScreen(),
        'roundinfo': (_) => RoundInfo(),
        'friend': (_) => FriendScreen(),
        'liveRound': (_) => LiveScoreScreen(),
        'courseInfo': (_) => CourseInformation(),
        'testView': (_) => TestView(),
      },
    );
  }
}
