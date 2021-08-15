import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/personalCard/confirmButton.dart';
import 'package:golfcaddie/components/personalCard/textField.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/vendor/storage.dart';

class GreenCardState extends StatefulWidget {
  @override
  State<GreenCardState> createState() => GreenCard();
}

class GreenCard extends State<GreenCardState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  final TextEditingController handicapController = TextEditingController();
  String gender = "MALE";
  String errorValue = "";

  GreenCard() {
    setValues();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: this.errorValue == '' ? 0 : 30,
                child: Text(
                  this.errorValue,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal),
                ),
              ),
              WhiteTextField(
                hint: 'Naam',
                obfuscated: false,
                controller: nameController,
                icon: Icons.person_outline,
                number: false,
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'E-mail',
                obfuscated: false,
                controller: emailController,
                icon: Icons.mail_outline,
                number: false,
                email: true,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'Huidig wachtwoord',
                obfuscated: true,
                controller: passwordController,
                icon: Icons.lock_clock_outlined,
                number: false,
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'Nieuw wachtwoord',
                obfuscated: true,
                controller: newPasswordController,
                icon: Icons.lock_outline,
                number: false,
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'Wachtwoord herhalen',
                obfuscated: true,
                controller: checkPasswordController,
                icon: Icons.lock_outline,
                number: false,
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                number: true,
                hint: 'Handicap',
                obfuscated: false,
                controller: handicapController,
                icon: Icons.sports_golf_outlined,
                email: false,
              ),
              SizedBox(height: 10),
              SizedBox(
                  width: max(250, MediaQuery.of(context).size.width * 0.50),
                  child: DropdownButtonFormField(
                    style: TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                    dropdownColor: Theme.of(context).colorScheme.secondary,
                    iconEnabledColor: Colors.white,
                    isDense: true,
                    items: [
                      {'title': "Man", 'val': "MALE"},
                      {'title': "Vrouw", 'val': "FEMALE"},
                      {'title': "Overig", 'val': "UNSPECIFIED"}
                    ].map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value['val'],
                        child: Text(
                          value['title'],
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      this.gender = newValue as String;
                      setState(() {});
                      // do other stuff with _category
                    },
                    value: gender,
                    decoration: InputDecoration(
                      isDense: true,
                      focusColor: Theme.of(context).colorScheme.primary,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8),
                      icon: Icon(
                        Icons.male_outlined,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
                      filled: false,
                    ),
                  )),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 135,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 16),
                            backgroundColor: Theme.of(context).colorScheme.error,
                            primary: Theme.of(context).colorScheme.onError,
                            fixedSize: Size(135, 10),
                            alignment: Alignment.center),
                        child: Text(
                          'Uitloggen',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Storage().delItem('jwt');
                          Navigator.of(context).pushReplacementNamed('/');
                        }),
                  ),
                  WhiteConfirmButton(
                      name: nameController,
                      email: emailController,
                      currentPassword: passwordController,
                      newPassword: newPasswordController,
                      newVerifiedPassword: checkPasswordController,
                      handicap: handicapController,
                      gender: gender,
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
              )
            ],
          )),
    );
  }

  void setValues() async {
    Dio dio = await AppUtils.getDio();
    dio.get('/profile/me').then((value) {
      print(value.data);
      nameController.text = value.data['name'];
      emailController.text = value.data['email'];
      gender = value.data['gender'];
      handicapController.text = value.data['handicap'].toString();
      if (this.mounted) setState(() {});
    }).catchError((e) {
      setState(() {
        this.errorValue = e.response.data['error'];
      });
    });
  }
}
