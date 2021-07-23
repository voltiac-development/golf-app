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

  @override
  Widget build(BuildContext context) {
    if (!callMade) {
      getFriendInformation(ModalRoute.of(context)!.settings.arguments as String);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: DefaultAppBar(title: "VRIEND BEKIJKEN", person: true, back: true),
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Center(
            child: !this.callMade
                ? new CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface,
                  )
                : Column(children: [
                    Text(this.friend.name),
                    ElevatedButton(
                        onPressed: () => removeFriend(),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text('Verwijderen'),
                        ))
                  ])),
      ),
    );
  }

  void getFriendInformation(id) async {
    Dio dio = Dio();
    Map<String, String> headers = await AppUtils.getHeaders();
    dio.get(AppUtils.apiUrl + "friend/get/" + id, options: Options(headers: headers)).then((value) {
      print(value.data);
      Map<String, dynamic> friend = value.data['friend'];
      print(friend['name']);
      this.friend = Friend(friend['name'], friend['handicap'], friend['id'], friend['image']);
      this.callMade = true;
      setState(() {});
    });
  }

  void removeFriend() async {
    Dio dio = Dio();
    Map<String, String> headers = await AppUtils.getHeaders();
    dio.delete(AppUtils.apiUrl + "friend/remove", data: {'friendId': this.friend.getId}, options: Options(headers: headers)).then((value) => print(value.data));
  }
}
