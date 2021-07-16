import 'package:flutter/material.dart';
import 'package:golfcaddie/components/friends/card.dart';
import 'package:golfcaddie/components/personalCard/customAnimation.dart';

class AddFriendPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddFriendScreen();
}

class AddFriendScreen extends State<AddFriendPopup> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'add_friend',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.surface,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [FriendCard()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
