import 'package:flutter/material.dart';

class Teeboxes extends StatelessWidget {
  final List<Color?> colors = [
    Colors.grey[300],
    Colors.lightBlue,
    Colors.yellow,
    Colors.red,
    Colors.orange
  ];
  final Color hide;
  final Color highlight;

  final List<String> colorTypes = ["WHITE", "BLUE", "YELLOW", "RED", "ORANGE"];
  final List<int> test = [0, 1, 2, 3, 4];
  final String tees;
  final int chosenIndex;
  final ValueChanged<int> onTap;
  Teeboxes(
      {required this.tees,
      required this.chosenIndex,
      required this.onTap,
      required this.hide,
      required this.highlight});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          for (int i = 0; i < colorTypes.length; i++)
            tees.contains(colorTypes[i])
                ? Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                        child: IconButton(
                          icon: Icon(Icons.sports_golf,
                              size: 30, color: colors[i]),
                          onPressed: () {
                            this.onTap(i);
                          },
                          splashColor: this.hide,
                          focusColor: this.hide,
                          highlightColor: this.hide,
                        ),
                        decoration: this.chosenIndex == test[i]
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(width: 1, color: this.highlight))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(width: 1, color: this.hide))),
                  )
                : SizedBox()
        ],
      ),
    );
  }
}
