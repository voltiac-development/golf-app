import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_golf/components/appbar.dart';
import 'package:flutter_golf/components/friends/friendcard.dart';
import 'package:flutter_golf/models/Friend.dart';

class FriendsScreen extends StatefulWidget {
  @override
  State<FriendsScreen> createState() => FriendsState();
}

class FriendsState extends State<FriendsScreen> {
  List<Friend> friends = [
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
    Friend('Maartje Vermeulen', 23.20, '1dd4bc6f-5fce-4aa3-9ae7-9587bab868b9',
        'https://cdn.bartverm.dev/golfcaddie/clubs/dorpswaard.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        primary: Colors.white,
        fixedSize: Size(175, 8),
        elevation: 2,
        alignment: Alignment.centerLeft);
    return Scaffold(
        appBar: DefaultAppBar(
          title: "VRIENDEN",
          person: true,
          back: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
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
                      // TODO LISTVIEW??
                      children: [
                        OutlinedButton(
                          style: style,
                          child: Text(
                            'VRIEND TOEVOEGEN',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {},
                        ),
                        ...friends
                            .map((item) => new FriendCard(friend: item))
                            .toList()
                      ],
                    )))));
  }
}
