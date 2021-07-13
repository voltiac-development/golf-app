import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golf/components/friends/sendButton.dart';
import 'package:flutter_golf/components/personalCard/textField.dart';

class FriendCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FriendCardState();
}

class FriendCardState extends State<FriendCard> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController checkPasswordController = TextEditingController();
  String errorValue = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Vriend toevoegen',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: this.errorValue == '' ? 0 : 30,
                child: Text(
                  this.errorValue,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.normal),
                ),
              ),
              WhiteTextField(
                hint: 'E-mail',
                obfuscated: false,
                controller: emailController,
                icon: Icons.mail_outlined,
                email: false,
              ),
              SizedBox(height: 20),
              WhiteSendButton(
                  email: emailController,
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
          ))),
    );
  }
}
