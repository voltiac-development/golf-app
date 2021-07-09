import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golf/env.dart';
import 'package:http/http.dart' as http;

class WhiteSendButton extends StatelessWidget {
  final TextEditingController email;
  final ValueChanged<String> onError;

  WhiteSendButton({Key? key, required this.email, required this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 155,
      child: OutlinedButton.icon(
          style: style,
          icon: Icon(Icons.person_add_alt_1_outlined),
          label: Text(
            'Versturen',
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            sendNewEdit(context);
          }),
    );
  }

  void sendNewEdit(BuildContext context) async {
    http.patch(Uri.parse(AppUtils.apiUrl + 'friend/add'),
        headers: await AppUtils.getHeaders(),
        body: {
          "email": email.text,
        }).then((value) {
      if (value.body != "\"SUCCESS\"") {
        Map<String, dynamic> body = jsonDecode(value.body);
        this.onError(body['error']);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Profiel successvol aangepast."),
              backgroundColor: Theme.of(context).colorScheme.primary),
        );
      }
    });
  }
}

final ButtonStyle style = OutlinedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 16),
    backgroundColor: Colors.white,
    primary: Colors.black,
    fixedSize: Size(155, 10),
    alignment: Alignment.center);
