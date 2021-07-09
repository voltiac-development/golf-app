import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golf/components/appbar.dart';
import 'package:flutter_golf/components/friends/addFriendPopup.dart';
import 'package:flutter_golf/components/friends/friendcard.dart';
import 'package:flutter_golf/components/friends/requestFriendPopup.dart';
import 'package:flutter_golf/models/Friend.dart';
import 'package:flutter_golf/vendor/heroDialogRoute.dart';

import 'package:http/http.dart' as http;

import '../env.dart';

class FriendsScreen extends StatefulWidget {
  @override
  State<FriendsScreen> createState() => FriendsState();
}

class FriendsState extends State<FriendsScreen> {
  List<Friend> friends = [];

  FriendsState({Key? key}) {
    retrieveFriends();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        primary: Colors.white,
        fixedSize: Size(118, 8),
        elevation: 2,
        alignment: Alignment.centerLeft);
    return Scaffold(
        appBar: DefaultAppBar(
          title: "VRIENDEN",
          person: true,
          back: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height - 56,
                decoration: BoxDecoration(
                    color: Color(0xFFffffff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: 'add_friend',
                                  child: OutlinedButton(
                                    style: style,
                                    child: Text(
                                      'TOEVOEGEN',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        HeroDialogRoute(
                                          builder: (context) => Center(
                                            child: AddFriendPopup(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Hero(
                                  tag: 'friend_requests',
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        primary: Colors.white,
                                        fixedSize: Size(117, 8),
                                        elevation: 2,
                                        alignment: Alignment.centerLeft),
                                    child: Text(
                                      'VERZOEKEN',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        HeroDialogRoute(
                                          builder: (context) => Center(
                                            child: RequestFriendPopup(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            ...friends
                                .map((item) => new FriendCard(friend: item))
                                .toList()
                          ],
                        ))))));
  }

  void retrieveFriends() async {
    http
        .get(Uri.parse(AppUtils.apiUrl + "friend/all"),
            headers: await AppUtils.getHeaders())
        .then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        List<dynamic>.from(response['friends']).forEach((e) {
          this
              .friends
              .add(Friend(e['name'], e['handicap'], e['id'], e['image']));
        });
        setState(() {});
      }
    });
  }
}
