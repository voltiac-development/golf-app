import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoltiacLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "log-in met: ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        GestureDetector(
          onTap: () {
            print('voltiac pressed');
          },
          child: Container(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Image.network(
                  'https://cdn.bartverm.dev/voltiac/transparentBlack.png',
                  height: 30,
                  width: 55,
                ),
              ),
              decoration:
                  BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primary), borderRadius: BorderRadius.all(Radius.circular(25)), color: Colors.white),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 10, offset: Offset.fromDirection(10)),
              ],
            ),
          ),
        )
      ],
    );
  }
}
