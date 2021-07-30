import 'package:flutter/material.dart';

class CourseInfo extends StatelessWidget {
  CourseInfo({Key? key, required this.white, required this.blue, required this.yellow, required this.red, required this.orange, required this.holes}) : super(key: key) {
    if (this.white.length > 0) {
      total += 50;
    }
    if (this.blue.length > 0) {
      total += 50;
    }
    if (this.yellow.length > 0) {
      total += 50;
    }
    if (this.red.length > 0) {
      total += 50;
    }
    if (this.orange.length > 0) {
      total += 50;
    }
  }

  final int holes;

  final List<int> white;
  final List<int> blue;
  final List<int> yellow;
  final List<int> red;
  final List<int> orange;
  late int total = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50 + this.total.toDouble(),
          height: double.parse((45 * this.holes).toString()),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.white54,
                blurRadius: 5.0,
                offset: Offset(0, 10),
                spreadRadius: 0.5,
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular((325 - this.total).toDouble()),
          child: Column(
            children: [
              for (int x = 0; x < this.holes; x++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 45,
                      child: Container(
                          decoration: BoxDecoration(
                            border: getBorderType(x, 0),
                            // borderRadius: getBorderRadius(x, 0),
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text((x + 1).toString()),
                          ])),
                    ),
                    this.white.length > 0
                        ? SizedBox(
                            width: 50,
                            height: 45,
                            child: Container(
                                decoration: BoxDecoration(border: getBorderType(x, 1)),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                  Text(
                                    white[x].toString(),
                                  ),
                                ])),
                          )
                        : SizedBox(),
                    this.blue.length > 0
                        ? SizedBox(
                            width: 50,
                            height: 45,
                            child: Container(
                                decoration: BoxDecoration(border: getBorderType(x, 2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(blue[x].toString()),
                                  ],
                                )),
                          )
                        : SizedBox(),
                    this.yellow.length > 0
                        ? SizedBox(
                            width: 50,
                            height: 45,
                            child: Container(
                                decoration: BoxDecoration(border: getBorderType(x, 2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(yellow[x].toString()),
                                  ],
                                )),
                          )
                        : SizedBox(),
                    this.red.length > 0
                        ? SizedBox(
                            width: 50,
                            height: 45,
                            child: Container(
                                decoration: BoxDecoration(border: getBorderType(x, 2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(red[x].toString()),
                                  ],
                                )),
                          )
                        : SizedBox(),
                    this.orange.length > 0
                        ? SizedBox(
                            width: 50,
                            height: 45,
                            child: Container(
                                decoration: BoxDecoration(border: getBorderType(x, 2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(orange[x].toString()),
                                  ],
                                )),
                          )
                        : SizedBox(),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  BoxBorder? getBorderType(y, x) {
    BorderSide borderHalf = BorderSide(color: Colors.black, width: 0.5);
    BorderSide border = BorderSide(color: Colors.black, width: 1);
    if (x == 0) {
      if (y == 0) return Border(top: border, bottom: borderHalf, left: border, right: borderHalf);
      if (y == this.holes - 1) return Border(top: borderHalf, bottom: border, left: border, right: borderHalf);
      return Border(top: borderHalf, bottom: borderHalf, left: border, right: borderHalf);
    }
    if (x == 4) {
      if (y == 0) return Border(top: border, bottom: borderHalf, left: borderHalf, right: border);
      if (y == this.holes - 1) return Border(top: borderHalf, bottom: border, left: borderHalf, right: border);
      return Border(top: borderHalf, bottom: borderHalf, left: borderHalf, right: border);
    }
    if (y == 0) {
      return Border(top: border, left: borderHalf, right: borderHalf, bottom: borderHalf);
    }
    if (y == this.holes - 1) {
      return Border(top: borderHalf, left: borderHalf, right: borderHalf, bottom: border);
    }
    return Border.all(color: Colors.black, width: 0.5);
  }

  BorderRadiusGeometry? getBorderRadius(y, x) {
    if (x == 0) if (y != 0 && y != this.holes - 1)
      return null;
    else
      return BorderRadius.only(topLeft: Radius.circular(y == 0 ? 10 : 0), bottomLeft: Radius.circular(y == this.holes - 1 ? 10 : 0));
    else
      return BorderRadius.only(topRight: Radius.circular(y == 0 ? 10 : 0), bottomRight: Radius.circular(y == this.holes - 1 ? 10 : 0));
  }
}
