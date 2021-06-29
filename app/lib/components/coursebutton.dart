import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  BtnWidget(
      {Key? key, required this.text, required this.icon, required this.routeTo})
      : super(key: key);

  final IconData icon;
  final String text;
  final String routeTo;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: Color(0xFF9CCD6C),
        primary: Colors.white,
        fixedSize: Size(250, 10),
        elevation: 2,
        alignment: Alignment.centerLeft);
    return Container(
      child: OutlinedButton.icon(
        style: style,
        icon: Icon(this.icon),
        label: Text(
          this.text,
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(this.routeTo);
        },
      ),
      margin: const EdgeInsets.only(top: 10.0),
    );
  }
}
