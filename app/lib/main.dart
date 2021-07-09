import 'package:flutter/material.dart';

//Custom screens
import 'views/login.dart';
import 'views/register.dart';
import 'views/allscores.dart';
import 'views/dashboard.dart';
import 'package:flutter_golf/views/forgot.dart';
import 'package:flutter_golf/views/friends.dart';
import 'package:flutter_golf/views/searchCourse.dart';

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
        'allscores': (_) => AllScoresScreen(),
        'forgotpassword': (_) => ForgotScreen(),
        'searchcourse': (_) => SearchCourseScreen(),
        'friends': (_) => FriendsScreen()
      },
    );
  }
}
