import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/personalCard/confirmButton.dart';
import 'package:golfcaddie/components/personalCard/textField.dart';
import 'package:golfcaddie/env.dart';

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
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'E-mail',
                obfuscated: false,
                controller: emailController,
                icon: Icons.mail_outline,
                email: true,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'Huidig wachtwoord',
                obfuscated: true,
                controller: passwordController,
                icon: Icons.lock_clock_outlined,
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'Nieuw wachtwoord',
                obfuscated: true,
                controller: newPasswordController,
                icon: Icons.lock_outline,
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'Nieuw wachtwoord opnieuw',
                obfuscated: true,
                controller: checkPasswordController,
                icon: Icons.lock_outline,
                email: false,
              ),
              SizedBox(height: 10),
              WhiteTextField(
                hint: 'Handicap',
                obfuscated: true,
                controller: handicapController,
                icon: Icons.sports_golf_outlined,
                email: false,
              ),
              SizedBox(height: 20),
              WhiteConfirmButton(
                  name: nameController,
                  email: emailController,
                  currentPassword: passwordController,
                  newPassword: newPasswordController,
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
    Dio dio = await AppUtils.getDio();
    dio.get('/profile/me').then((value) {
      nameController.text = value.data['name'];
      emailController.text = value.data['email'];
    }).catchError((e) {
      setState(() {
        this.errorValue = e.response.data['error'];
      });
    });
  }
}
