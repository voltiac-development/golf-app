import 'package:flutter/material.dart';
import 'package:flutter_golf/components/friends/requestscard.dart';
import 'package:flutter_golf/components/personalCard/customAnimation.dart';

class RequestFriendPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RequestFriendScreen();
}

class RequestFriendScreen extends State<RequestFriendPopup> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'friend_requests',
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
                  mainAxisSize: MainAxisSize.max,
                  children: [RequestsCard()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
