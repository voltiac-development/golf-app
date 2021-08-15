import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/login/voltiac.dart';
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
  void initState() {
    super.initState();
    doSomeLongRunningCalculation();
  }

  Future<void> doSomeLongRunningCalculation() async {
    String? item = await new Storage().getItem('jwt');
    if (item != null && item != "" && item != 'null') {
      Navigator.of(context).pushReplacementNamed('dashboard');
    } else {
      print(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    doSomeLongRunningCalculation();
    final ButtonStyle style = OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      primary: Colors.white,
    );
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: DefaultAppBar(
          title: "GOLFCADDIE",
          back: false,
          person: false,
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VoltiacLogin(),
              SizedBox(height: 15),
              SizedBox(
                  width: max(250, MediaQuery.of(context).size.width * 0.50),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'E-mail',
                      icon: Icon(Icons.mail_outline),
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(),
                    ),
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
                      enabledBorder: OutlineInputBorder(),
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
                          color: Theme.of(context).colorScheme.secondary,
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

  void checkLogin(final context) async {
    Dio dio = await AppUtils.getDio();
    dio.post('/auth/login', data: {'email': emailController.text, 'password': passwordController.text}).then((value) async {
      Storage().setItem('jwt', value.data['jwtToken']);
      Navigator.of(context).pushNamed('dashboard');
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
