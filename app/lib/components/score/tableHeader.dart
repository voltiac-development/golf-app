import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({Key? key}) : super(key: key);

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
                  'holes',
                  style: headerStyle,
                ),
              ])),
        ),
        SizedBox(
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
                Text(
                  'si',
                  style: headerStyle,
                ),
              ])),
        ),
        SizedBox(
          width: 70,
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
                Text(
                  'par',
                  style: headerStyle,
                ),
              ])),
        ),
        SizedBox(
          width: 65,
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
                Text(
                  'strokes',
                  style: headerStyle,
                ),
              ])),
        ),
        SizedBox(
          width: 65,
          height: 30,
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  'score',
                  style: headerStyle,
                ),
              ])),
        ),
      ],
    );
  }
}
