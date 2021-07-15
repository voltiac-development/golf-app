import 'package:flutter/material.dart';

class TeeBoxes extends StatelessWidget {
  final List<Color?> colors = [
    Colors.grey[300],
    Colors.lightBlue,
    Colors.yellow,
    Colors.red,
    Colors.orange
  ];
  final List<String> colorTypes = ["WHITE", "BLUE", "YELLOW", "RED", "ORANGE"];
  final String tees;
  TeeBoxes({Key? key, required this.tees}) : super(key: key);

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
                    child: IconButton(
                      icon: Icon(Icons.sports_golf, size: 30, color: colors[i]),
                      onPressed: () {},
                    ))
                : SizedBox()
        ],
      ),
    );
  }
}
