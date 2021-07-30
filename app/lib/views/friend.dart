import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
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
                    ...this.rounds.map((element) => Text(element['startsAt'])).toList(),
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
      print(friend);
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
}
