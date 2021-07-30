import 'package:flutter/material.dart';

class CourseInfoHeader extends StatelessWidget {
  const CourseInfoHeader({Key? key, required this.white, required this.blue, required this.yellow, required this.red, required this.orange}) : super(key: key);

  final bool white;
  final bool blue;
  final bool yellow;
  final bool red;
  final bool orange;

  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = TextStyle(color: Theme.of(context).colorScheme.onSurface);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          height: 30,
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'hole',
                  style: headerStyle,
                ),
              ])),
        ),
        this.white
            ? SizedBox(
                width: 50,
                height: 30,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Icon(
                        Icons.sports_golf_outlined,
                        color: Colors.grey[300],
                      )
                    ])),
              )
            : SizedBox(),
        this.blue
            ? SizedBox(
                width: 50,
                height: 30,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        top: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Icon(
                        Icons.sports_golf_outlined,
                        color: Colors.lightBlue,
                      )
                    ])),
              )
            : SizedBox(),
        this.yellow
            ? SizedBox(
                width: 50,
                height: 30,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        top: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Icon(
                        Icons.sports_golf_outlined,
                        color: Colors.yellow,
                      )
                    ])),
              )
            : SizedBox(),
        this.red
            ? SizedBox(
                width: 50,
                height: 30,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        top: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Icon(
                        Icons.sports_golf_outlined,
                        color: Colors.red,
                      )
                    ])),
              )
            : SizedBox(),
        this.orange
            ? SizedBox(
                width: 50,
                height: 30,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Icon(
                        Icons.sports_golf_outlined,
                        color: Colors.orange,
                      )
                    ])),
              )
            : SizedBox(),
      ],
    );
  }
}
