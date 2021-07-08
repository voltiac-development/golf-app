import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_golf/components/personalCard/confirmButton.dart';
import 'package:flutter_golf/components/personalCard/textField.dart';
import 'package:flutter_golf/env.dart';
import 'package:http/http.dart' as http;

class GreenCardState extends StatefulWidget {
  @override
  State<GreenCardState> createState() => GreenCard();
}

class GreenCard extends State<GreenCardState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  String errorValue = "";

  GreenCard() {
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    // setValues();
    return SizedBox(
      height: 250,
      width: 300,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Profiel aanpassen',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 30,
                child: Text(
                  this.errorValue,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.normal),
                ),
              ),
              WhiteTextField(
                  hint: 'Naam',
                  obfuscated: false,
                  controller: nameController,
                  icon: Icons.person_outline),
              SizedBox(height: 10),
              WhiteTextField(
                  hint: 'E-mail',
                  obfuscated: false,
                  controller: emailController,
                  icon: Icons.mail_outline),
              SizedBox(height: 10),
              WhiteTextField(
                  hint: 'Huidig wachtwoord',
                  obfuscated: true,
                  controller: passwordController,
                  icon: Icons.lock_outline),
              SizedBox(height: 10),
              WhiteTextField(
                  hint: 'Nieuw wachtwoord',
                  obfuscated: true,
                  controller: checkPasswordController,
                  icon: Icons.lock_outline),
              SizedBox(height: 20),
              WhiteConfirmButton(
                  name: nameController,
                  email: emailController,
                  newPassword: passwordController,
                  newVerifiedPassword: checkPasswordController,
                  onError: (e) {
                    print(e);
                    setState(() {
                      this.errorValue = e;
                    });
                    Future.delayed(Duration(seconds: 5), () {
                      setState(() {
                        this.errorValue = "";
                      });
                    });
                  }),
            ],
          )),
    );
  }

  void setValues() async {
    http
        .get(Uri.parse(AppUtils.apiUrl + 'profile/me'),
            headers: await AppUtils.getHeaders())
        .then((value) {
      Map<String, dynamic> body = jsonDecode(value.body);
      nameController.text = body['name'];
      emailController.text = body['email'];
    });
  }
}
