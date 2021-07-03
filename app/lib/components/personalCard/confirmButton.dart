import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golf/env.dart';
import 'package:http/http.dart' as http;

class WhiteConfirmButton extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController newPassword;
  final TextEditingController newVerifiedPassword;

  WhiteConfirmButton(
      {Key? key,
      required this.name,
      required this.email,
      required this.newPassword,
      required this.newVerifiedPassword})
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
            // TODO API CALL
            sendNewEdit();
          }),
    );
  }

  void sendNewEdit() {
    http.post(Uri.parse(AppUtils.apiUrl + 'profile/me'),
        headers: AppUtils.getHeaders(),
        body: {
          "name": name.text,
          "email": email.text,
          "newPassword": newPassword.text,
          "verifiedPassword": newVerifiedPassword.text
        }).then((value) {
      print(value.body);
    });
  }
}

final ButtonStyle style = OutlinedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 16),
    backgroundColor: Colors.white,
    primary: Colors.black,
    fixedSize: Size(135, 10),
    alignment: Alignment.center);
