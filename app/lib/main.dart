import 'package:flutter/material.dart';

//Custom components
import 'views/dashboard.dart';

//Custom screens
import 'views/login.dart';
import 'views/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'golf-app',
      theme: ThemeData(
          primaryColor: Color(0xFF00B0F0),
          accentColor: Color(0xFF9CCD6C),
          backgroundColor: Color(0xFF115792)),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        'dashboard': (_) => DashboardScreen(),
        'register': (_) => RegisterScreen()
      },
    );
  }
}
