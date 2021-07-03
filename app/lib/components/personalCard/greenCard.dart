import 'package:flutter/material.dart';
import 'package:flutter_golf/components/personalCard/confirmButton.dart';
import 'package:flutter_golf/components/personalCard/textField.dart';

class GreenCard extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  newVerifiedPassword: checkPasswordController)
            ],
          )),
    );
  }
}
