import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../vendor/storage.dart';

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
    WidgetsBinding.instance!.addPostFrameCallback((_) => checkRoute(context));

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
            style: TextStyle(
                fontWeight: FontWeight.w200, color: Color(0xFFffffff)),
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
              Text(
                "log-in met: ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
              GestureDetector(
                onTap: () {
                  print('voltiac pressed');
                },
                child: Container(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Image(
                        image: AssetImage('transparentBlack.png'),
                        height: 30,
                        width: 55,
                      ),
                    ),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset.fromDirection(10)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
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
                  checkLogin(context);
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
              child: Row(
                children: [
                  SizedBox(
                    width: 135,
                    child: GestureDetector(
                      child: Text(
                        'registreren',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onTapDown: (details) {
                        Navigator.of(context).pushNamed('register');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: GestureDetector(
                      child: Text(
                        'wachtwoord vergeten',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red[400],
                        ),
                      ),
                      onTapDown: (details) {
                        Navigator.of(context).pushNamed('forgotpassword');
                      },
                    ),
                    width: 135,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )),
        ));
  }

  void checkLogin(final context) {
    http.post(Uri.parse(AppUtils.apiUrl + 'auth/login'), body: {
      'email': emailController.text,
      'password': passwordController.text
    }).then((value) async {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        //Success
        Storage().setItem('jwt', response['jwtToken']);
        Navigator.of(context).pushNamed('dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response['error']),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  void checkRoute(BuildContext context) {
    if (Storage().getItem('jwt') == null || Storage().getItem('jwt') == "") {
      Navigator.of(context).pushNamed('dashboard');
    }
  }
}
