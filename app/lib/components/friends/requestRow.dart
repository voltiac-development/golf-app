import 'package:flutter/material.dart';

class RequestRow extends StatelessWidget {
  final String name;
  final String email;
  final ValueChanged<void> onDecline;
  final ValueChanged<void> onAccept;

  RequestRow(
      {Key? key,
      required this.name,
      required this.email,
      required this.onDecline,
      required this.onAccept})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  this.email,
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.white),
                  softWrap: true,
                )
              ],
            ),
            Row(
              children: [
                Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.red,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 14,
                      ),
                      splashColor: Colors.red,
                      splashRadius: 20,
                    )),
                SizedBox(
                  width: 3,
                ),
                Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.green,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      splashColor: Colors.green,
                      splashRadius: 20,
                    ))
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
