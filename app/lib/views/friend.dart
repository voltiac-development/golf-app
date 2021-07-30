import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:day/day.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/models/Friend.dart';

import '../env.dart';

class FriendScreen extends StatefulWidget {
  FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<FriendScreen> {
  bool callMade = false;
  late Friend friend;
  List<dynamic> rounds = [];

  @override
  Widget build(BuildContext context) {
    if (!callMade) {
      getFriendInformation(ModalRoute.of(context)!.settings.arguments as String);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: DefaultAppBar(title: "VRIEND BEKIJKEN", person: true, back: true),
      body: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Center(
            child: !this.callMade
                ? new CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface,
                  )
                : Column(children: [
                    ColumnSuper(
                      children: [
                        Container(
                          decoration: BoxDecoration(boxShadow: [BoxShadow(offset: Offset(1, 1), color: Colors.black26, blurRadius: 15)]),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: Image.network(
                              'https://cdn.bartverm.dev/golfcaddie/util/profile_background.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [BoxShadow(offset: Offset(-1, -1), color: Colors.black12, blurRadius: 15)]),
                          child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              friend.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                      innerDistance: -50,
                    ),
                    Text(
                      this.friend.name.toLowerCase(),
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.sports_golf_outlined, size: 40),
                      SizedBox(
                        width: 5,
                      ),
                      Text(this.friend.handicap.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                    ]),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    ...this
                        .rounds
                        .map((e) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pushNamed('roundinfo', arguments: e['roundId']),
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(color: Colors.black45, offset: Offset.fromDirection(1), blurRadius: 2)],
                                        color: Theme.of(context).colorScheme.secondary,
                                        borderRadius: BorderRadius.circular(12)),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width * 0.76,
                                    child: Row(
                                      children: [
                                        new Image.network(
                                          e['image'],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 15, right: 15),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.76 - 75,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(Day.fromString(e['startsAt']).format('DD-MM-YYYY'),
                                                          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontWeight: FontWeight.bold)),
                                                      Text(
                                                        e['name'],
                                                        style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.onSecondary),
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  getIconForPlayers(e)
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(2))
                              ],
                            ))
                        .toList(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.error),
                        onPressed: () => removeFriend(),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            'Verwijderen',
                            style: TextStyle(color: Theme.of(context).colorScheme.onError),
                          ),
                        ))
                  ])),
      ),
    );
  }

  void getFriendInformation(id) async {
    Dio dio = await AppUtils.getDio();
    dio.get("/friend/get/" + id).then((value) {
      Map<String, dynamic> friend = value.data['friend'];
      this.friend = Friend(friend['name'], friend['handicap'], friend['id'], friend['image']);
      this.rounds = friend['rounds'];
      this.callMade = true;
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

  void removeFriend() async {
    Dio dio = await AppUtils.getDio();
    dio.delete("/friend/remove", data: {'friendId': this.friend.getId}).then((value) => print(value.data)).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              e.response.data['error'],
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
        });
  }

  Icon getIconForPlayers(round) {
    int count = 0;
    if (round['playerOne'] != null) count = count + 1;
    if (round['playerTwo'] != null) count = count + 1;
    if (round['playerThree'] != null) count = count + 1;
    if (round['playerFour'] != null) count = count + 1;

    switch (count) {
      case 1:
        return Icon(Icons.looks_one_outlined, color: Colors.white);
      case 2:
        return Icon(Icons.looks_two_outlined, color: Colors.white);
      case 3:
        return Icon(Icons.looks_3_outlined, color: Colors.white);
      case 4:
        return Icon(Icons.looks_4_outlined, color: Colors.white);
      default:
        return Icon(Icons.error);
    }
  }
}
