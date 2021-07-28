import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/env.dart';

class WhiteSendButton extends StatelessWidget {
  final TextEditingController email;
  final ValueChanged<String> onError;

  WhiteSendButton({Key? key, required this.email, required this.onError}) : super(key: key);

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
    Dio dio = await AppUtils.getDio();
    dio.post('/friend/add', data: {
      "friend": email.text,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profiel successvol aangepast."), backgroundColor: Theme.of(context).colorScheme.primary),
      );
    }).catchError((e) {
      this.onError(e.response['error']);
    });
  }
}

final ButtonStyle style = OutlinedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 16), backgroundColor: Colors.white, primary: Colors.black, fixedSize: Size(155, 10), alignment: Alignment.center);
