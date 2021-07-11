import 'package:flutter/material.dart';
import 'package:flutter_golf/components/friends/requestRow.dart';

class RequestsCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RequestsCardState();
}

class RequestsCardState extends State<RequestsCard> {
  String errorValue = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 140,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Vriend verzoeken',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: this.errorValue == '' ? 0 : 30,
                child: Text(
                  this.errorValue,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.normal),
                ),
              ),
              RequestRow(
                name: 'Bart Vermeulen',
                email: 'bartdgp@outlook.com',
                onDecline: (value) {
                  return;
                },
                onAccept: (value) {},
              ),
              RequestRow(
                name: 'Bart Vermeulen',
                email: 'bartdgp@outlook.com',
                onDecline: (value) {
                  return;
                },
                onAccept: (value) {},
              )
            ],
          ),
        ));
  }
}
