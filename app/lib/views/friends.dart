import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/friends/addFriendPopup.dart';
import 'package:golfcaddie/components/friends/friendcard.dart';
import 'package:golfcaddie/components/friends/requestFriendPopup.dart';
import 'package:golfcaddie/viewmodels/Friend.dart';
import 'package:golfcaddie/vendor/heroDialogRoute.dart';

import 'package:golfcaddie/env.dart';

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
        backgroundColor: Theme.of(context).colorScheme.surface, primary: Colors.white, fixedSize: Size(125, 8), elevation: 2, alignment: Alignment.centerLeft);
    return Scaffold(
        appBar: DefaultAppBar(
          title: "VRIENDEN",
          person: true,
          back: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
            height: MediaQuery.of(context).size.height - 56,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
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
                                    backgroundColor: Theme.of(context).colorScheme.surface,
                                    primary: Colors.white,
                                    fixedSize: Size(125, 8),
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
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                    children: [
                                      ...friends.map((item) => new FriendCard(friend: item)).toList(),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    )))));
  }

  void retrieveFriends() async {
    Dio dio = await AppUtils.getDio();
    dio.get("/friend/all").then((value) {
      List<dynamic>.from(value.data['friends']).forEach((e) {
        this.friends.add(Friend(e['name'], e['handicap'], e['id'], e['image'], e['gender']));
      });
      setState(() {});
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.response.data['error'],
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    });
  }
}
