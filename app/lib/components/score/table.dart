import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  @override
  void initState() {
    super.initState();
    this.controllers = [];
    for (int i = 0; i < 18; i++) {
      this.controllers.add(new TextEditingController());
      try {
        if (this.strokes[i] != null) this.controllers[i].text = this.strokes[i].toString();
      } catch (e) {}
    }
  }

  _ScoreTableState({required this.holePhc, required this.par, required this.score, required this.strokes, required this.si, required this.onScoreChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int x = 0; x < 9; x++)
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
              // Padding(
              //   padding: EdgeInsets.only(right: 5),
              // ),
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
                        si[x].toString(),
                      ),
                    ])),
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 5),
              // ),
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
                        Text(par[x].toString()),
                        Text(
                          "+" + holePhc[x].toString(),
                          style: TextStyle(fontFeatures: [FontFeature.superscripts()]),
                        ),
                      ],
                    )),
              ),
              // Padding(
              //   padding: EdgeInsets.only(right: 5),
              // ),
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
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: getBorderRadius(x, 4),
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
    );
  }

  BoxBorder? getBorderType() {}

  BorderRadiusGeometry getBorderRadius(i, index) {
    if (index == 0)
      return BorderRadius.only(topLeft: Radius.circular(i == 0 ? 10 : 0), bottomLeft: Radius.circular(i == 8 ? 10 : 0));
    else
      return BorderRadius.only(topRight: Radius.circular(i == 0 ? 10 : 0), bottomRight: Radius.circular(i == 8 ? 10 : 0));
  }
}
