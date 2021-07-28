import 'package:flutter/material.dart';

class CourseInfo extends StatelessWidget {
  CourseInfo({Key? key}) : super(key: key);

  final int holes = 18;

  final List<int> white = new List.filled(18, 200);
  final List<int> blue = new List.filled(18, 175);
  final List<int> yellow = new List.filled(18, 150);
  final List<int> red = new List.filled(18, 125);
  final List<int> orange = new List.filled(18, 100);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 300,
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
          borderRadius: BorderRadius.circular(100),
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
                    SizedBox(
                      width: 50,
                      height: 45,
                      child: Container(
                          decoration: BoxDecoration(border: getBorderType(x, 1)),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(
                              white[x].toString(),
                            ),
                          ])),
                    ),
                    SizedBox(
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
                    ),
                    SizedBox(
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
                    ),
                    SizedBox(
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
                    ),
                    SizedBox(
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
                    ),
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
