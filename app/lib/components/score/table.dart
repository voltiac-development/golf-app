import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:golfcaddie/components/score/tableHeader.dart';

class ScoreTable extends StatefulWidget {
  final List<int> holePhc;
  final List<int> par;
  final List<int> score;
  final List<int?> strokes;
  final List<int> si;
  final ValueChanged<List<int>> onScoreChanged;

  ScoreTable({Key? key, required this.holePhc, required this.par, required this.score, required this.strokes, required this.si, required this.onScoreChanged})
      : super(key: key);

  @override
  _ScoreTableState createState() =>
      _ScoreTableState(holePhc: this.holePhc, par: this.par, score: this.score, strokes: this.strokes, si: this.si, onScoreChanged: onScoreChanged);
}

class _ScoreTableState extends State<ScoreTable> {
  List<int> holePhc;
  List<int> par;
  List<int> score;
  List<int?> strokes;
  List<int> si;
  List<TextEditingController> controllers = [];
  ValueChanged<List<int>> onScoreChanged;
  int holes = 18;

  @override
  @override
  void initState() {
    super.initState();
    this.controllers = [];
    for (int i = 0; i < this.holes; i++) {
      this.controllers.add(new TextEditingController());
      try {
        if (this.strokes[i] != null) this.controllers[i].text = this.strokes[i].toString();
      } catch (e) {}
    }
  }

  _ScoreTableState({required this.holePhc, required this.par, required this.score, required this.strokes, required this.si, required this.onScoreChanged});

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
                              si[x].toString(),
                            ),
                          ])),
                    ),
                    SizedBox(
                      //PAR
                      width: 70,
                      height: 45,
                      child: Container(
                          decoration: BoxDecoration(border: getBorderType(x, 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(par[x].toString()),
                              Text(
                                "+" + holePhc[x].toString(),
                                style: TextStyle(fontFeatures: [FontFeature.superscripts()]),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 65,
                      height: 45,
                      child: Container(
                          decoration: BoxDecoration(border: getBorderType(x, 3)),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            TextField(
                              onChanged: (value) => this.onScoreChanged([x, value == "" ? -1 : int.parse(value)]),
                              controller: this.controllers[x],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(isDense: true, focusedBorder: InputBorder.none),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                          ])),
                    ),
                    SizedBox(
                      width: 65,
                      height: 45,
                      child: Container(
                          decoration: BoxDecoration(
                            border: getBorderType(x, 4),
                            // borderRadius: getBorderRadius(x, 4),
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Text(
                              score[x].toString(),
                            ),
                          ])),
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
