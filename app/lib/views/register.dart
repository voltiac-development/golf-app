import 'dart:math';

import 'package:flutter/material.dart';

import '../components/appbar.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  String favCourse = "De Dorpswaard";
  String? errorHint;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: Theme.of(context).accentColor,
      primary: Colors.white,
    );

    return Scaffold(
      appBar: DefaultAppBar(
        title: 'REGISTEREN',
        person: false,
        back: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
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
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Voor en achternaam',
                    icon: Icon(Icons.person_outline),
                    contentPadding: EdgeInsets.all(8),
                    isDense: true,
                  ),
                )),
            SizedBox(height: 10),
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
            SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.50),
                child: DropdownButtonFormField(
                  isDense: true,
                  //TODO ADD API CALL
                  items: <String>['De Dorpswaard', 'Havelij', 'The Duke']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    // do other stuff with _category
                  },
                  value: favCourse,
                  decoration: InputDecoration(
                    isDense: true,
                    focusColor: Theme.of(context).primaryColor,
                    contentPadding: EdgeInsets.all(8),
                    icon: Icon(Icons.track_changes),
                    border: new OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                            style: BorderStyle.solid)),
                    filled: false,
                  ),
                )),
            SizedBox(height: 10),
            ElevatedButton(
              style: style,
              onPressed: () {
                print(nameController.text +
                    " : " +
                    emailController.text +
                    " : " +
                    passwordController.text);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text('Registreren'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}