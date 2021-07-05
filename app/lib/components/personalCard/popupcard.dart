import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golf/components/personalCard/customAnimation.dart';
import 'package:flutter_golf/components/personalCard/greenCard.dart';

class PopupCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PopupScreen();
}

class PopupScreen extends State<PopupCard> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'profile_edit',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondary,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [GreenCardState()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
