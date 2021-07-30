import 'package:dio/dio.dart';
import 'package:golfcaddie/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteConfirmButton extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController currentPassword;
  final TextEditingController newPassword;
  final TextEditingController newVerifiedPassword;
  final TextEditingController handicap;
  final ValueChanged<String> onError;

  WhiteConfirmButton(
      {Key? key,
      required this.currentPassword,
      required this.name,
      required this.email,
      required this.newPassword,
      required this.newVerifiedPassword,
      required this.handicap,
      required this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      child: OutlinedButton.icon(
          style: style,
          icon: Icon(Icons.save_alt_outlined),
          label: Text(
            'Bijwerken',
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            sendNewEdit(context);
          }),
    );
  }

  void sendNewEdit(BuildContext context) async {
    Dio dio = await AppUtils.getDio();
    dio.post("/profile/me", data: {
      "name": name.text,
      "email": email.text,
      "currentPassword": currentPassword.text,
      "newPassword": newPassword.text,
      "verifiedPassword": newVerifiedPassword.text,
      "handicap": handicap.text,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Profiel is successvol aangepast.",
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ));
    }).catchError((e) {
      this.onError(e.response.data['error']);
    });
  }
}

final ButtonStyle style = OutlinedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 16), backgroundColor: Colors.white, primary: Colors.black, fixedSize: Size(135, 10), alignment: Alignment.center);
