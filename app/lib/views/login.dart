import 'dart:math';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorHint;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: Theme.of(context).accentColor,
      primary: Colors.white,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Center(
            child: Text(
          "GOLFCADDIE",
          style:
              TextStyle(fontWeight: FontWeight.w200, color: Color(0xFFffffff)),
        )),
        elevation: 0,
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
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'E-mail',
                      icon: Icon(Icons.mail_outline),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true),
                )),
            SizedBox(height: 10, width: MediaQuery.of(context).size.width),
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Wachtwoord',
                    icon: Icon(Icons.lock_outline),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                  ),
                  autocorrect: false,
                  obscureText: true,
                )),
            SizedBox(height: 10),
            ElevatedButton(
              style: style,
              onPressed: () {
                checkRegister(context);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text('Inloggen'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: GestureDetector(
                child: Text(
                  'registreren',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onTapDown: (details) {
                  Navigator.of(context).pushNamed('register');
                },
              ))),
    );
  }

  void checkRegister(final context) {
    print(emailController.text + " " + passwordController.text);
    Navigator.of(context).pushNamed('dashboard');
  }
}