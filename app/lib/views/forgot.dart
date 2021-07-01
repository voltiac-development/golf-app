import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golf/components/appbar.dart';

class ForgotScreen extends StatelessWidget {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: Theme.of(context).accentColor,
      primary: Colors.white,
    );
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar:
            DefaultAppBar(title: 'WACHTWOORD RESET', person: false, back: true),
        body: Container(
            decoration: BoxDecoration(
                color: Color(0xFFffffff),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
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
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    requestForgotten(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text('Aanvragen'),
                  ),
                ),
              ],
            )));
  }

  void requestForgotten(final context) async {
    print(emailController.text);
  }
}