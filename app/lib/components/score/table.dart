import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreTable extends StatelessWidget {
  const ScoreTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int x = 0; x < 18; x++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 45,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: getBorderRadius(x, 0),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text((x + 1).toString()),
                    ])),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
              ),
              SizedBox(
                width: 50,
                height: 45,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text(
                        (x + new Random().nextInt(25)).toString(),
                      ),
                    ])),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
              ),
              SizedBox(
                //PAR
                width: 70,
                height: 45,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text((x + new Random().nextInt(5)).toString()),
                        Text(
                          "+1",
                          style: TextStyle(fontFeatures: [FontFeature.superscripts()]),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
              ),
              SizedBox(
                width: 65,
                height: 45,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(isDense: true, focusedBorder: InputBorder.none),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ])),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
              ),
              SizedBox(
                width: 65,
                height: 45,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: getBorderRadius(x, 4),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text(
                        x.toString(),
                      ),
                    ])),
              ),
            ],
          ),
      ],
    );
  }

  BoxBorder? getBorderType() {}

  BorderRadiusGeometry getBorderRadius(i, index) {
    if (index == 0)
      return BorderRadius.only(topLeft: Radius.circular(i == 0 ? 10 : 0), bottomLeft: Radius.circular(i == 17 ? 10 : 0));
    else
      return BorderRadius.only(topRight: Radius.circular(i == 0 ? 10 : 0), bottomRight: Radius.circular(i == 17 ? 10 : 0));
  }
}
