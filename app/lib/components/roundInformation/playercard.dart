import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final dynamic roundInformation;
  final List<Color?> colors = [Colors.grey[300], Colors.lightBlue, Colors.yellow, Colors.red, Colors.orange];
  final String name;
  final String handicap;
  final String tee;
  final IconData number;

  PlayerCard({Key? key, required this.roundInformation, required this.name, required this.tee, required this.handicap, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.80 > 225 ? MediaQuery.of(context).size.width * 0.80 : 225,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border:
                      Border.all(color: this.roundInformation['key'] == name ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.surface, width: 2),
                  boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(1, 1), blurRadius: 1)]),
              child: Padding(
                padding: EdgeInsets.only(top: 15, right: 15, bottom: 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      this.number,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      roundInformation[this.name],
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Spacer(),
                    Icon(
                      Icons.sports_golf_outlined,
                      color: colors[roundInformation[this.tee]],
                    ),
                    Padding(padding: EdgeInsets.only(right: 5)),
                    SizedBox(
                      child: Text(
                        roundInformation[this.handicap].toString(),
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                        textAlign: TextAlign.right,
                      ),
                      width: 30,
                    ),
                    Icon(
                      Icons.golf_course_outlined,
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                  ],
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.all(2),
        )
      ],
    );
  }
}
