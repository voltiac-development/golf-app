import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteTextField extends StatelessWidget {
  final String hint;
  final bool obfuscated;
  final TextEditingController controller;
  final IconData icon;
  final bool email;

  WhiteTextField(
      {Key? key,
      required this.hint,
      required this.obfuscated,
      required this.controller,
      required this.icon,
      required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: max(250, MediaQuery.of(context).size.width * 0.50),
        child: TextField(
          keyboardType:
              this.email ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            hintText: this.hint,
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            icon: Icon(
              this.icon,
              color: Colors.white,
            ),
            contentPadding: EdgeInsets.all(8),
            isDense: true,
          ),
          style: TextStyle(
            color: Colors.white,
            decorationColor: Colors.white,
          ),
          autocorrect: false,
          obscureText: this.obfuscated,
          cursorColor: Colors.white,
          controller: controller,
        ));
  }
}
