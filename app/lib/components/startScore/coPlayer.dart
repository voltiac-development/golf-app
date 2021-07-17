import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golfcaddie/components/personalCard/customAnimation.dart';
import 'package:golfcaddie/components/startScore/teeBoxes.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/models/Friend.dart';
import 'package:golfcaddie/vendor/heroDialogRoute.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class CoPlayer extends StatefulWidget {
  final String tees;
  CoPlayer({Key? key, required this.tees}) : super(key: key);

  @override
  _CoPlayerState createState() {
    return _CoPlayerState(t: this.tees);
  }
}

class _CoPlayerState extends State<CoPlayer> {
  String t;
  final TextStyle annotation =
      TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w100);

  List<Friend?> players = [null, null, null];
  List<IconData> iconPlayers = [
    Icons.looks_one_outlined,
    Icons.looks_two_outlined,
    Icons.looks_3_outlined
  ];

  _CoPlayerState({required this.t});

  @override
  Widget build(BuildContext context) {
    this.t = widget.tees;
    return Column(
      children: [
        Text(
          'mede-spelers',
          style: annotation,
        ),
        Padding(
          padding: EdgeInsets.all(2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < iconPlayers.length; i++)
              Hero(
                tag: 'player_' + i.toString(),
                child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(
                          iconPlayers[i],
                          size: 30,
                          color: this.players[i] == null
                              ? Theme.of(context).colorScheme.surface
                              : Colors.greenAccent,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            HeroDialogRoute(
                              builder: (context) => Center(
                                child: CoPlayerCard(
                                  id: i,
                                  tees: this.t,
                                  friend: this.players[i],
                                  selectedFriends: this.players,
                                  returnedFriend: (value) {
                                    setState(() {
                                      this.players[i] = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              ),
          ],
        ),
      ],
    );
  }
}

class CoPlayerCard extends StatefulWidget {
  final int id;
  final String tees;
  final ValueChanged<Friend?> returnedFriend;
  final Friend? friend;
  final List<Friend?> selectedFriends;
  CoPlayerCard(
      {Key? key,
      required this.id,
      required this.tees,
      required this.returnedFriend,
      required this.friend,
      required this.selectedFriends})
      : super(key: key);

  @override
  _CoPlayerCardState createState() {
    return _CoPlayerCardState(
        id: this.id,
        tees: this.tees,
        returnedFriend: this.returnedFriend,
        friend: this.friend,
        selectedFriends: this.selectedFriends);
  }
}

class _CoPlayerCardState extends State<CoPlayerCard> {
  int id;
  Friend? friend;
  List<UserRequest> friends = [];
  List<Friend?> selectedFriends;
  String tees;
  String chosen = "";
  String errorValue = "";
  int chosenIndex = -1;
  ValueChanged<Friend?> returnedFriend;
  TextEditingController playerController = new TextEditingController();
  _CoPlayerCardState(
      {required this.id,
      required this.tees,
      required this.returnedFriend,
      required this.friend,
      required this.selectedFriends}) {
    retrieveFriends();
    if (this.friend != null) {
      this.chosen = this.friend!.getId;
      this.playerController.text = this.friend!.name;
      this.chosenIndex = this.friend!.handicap.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'player_' + id.toString(),
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.surface,
          child: SizedBox(
            height: MediaQuery.of(context).size.height < 350
                ? MediaQuery.of(context).size.height
                : 350,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Mede-speler kiezen',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      child: Text(this.errorValue,
                          style: TextStyle(color: Colors.red)),
                      height: this.errorValue == "" ? 0 : 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: playerController,
                          decoration: InputDecoration(
                            isDense: true,
                            focusColor: Theme.of(context).primaryColor,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            filled: false,
                          ),
                          style: TextStyle(color: Colors.white)),
                      suggestionsCallback: (pattern) async {
                        return filterSearch(pattern);
                      },
                      noItemsFoundBuilder: (context) => Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Er zijn geen vrienden beschikbaar.',
                        ),
                      ),
                      itemBuilder: (context, suggestion) {
                        UserRequest u = suggestion as UserRequest;
                        return ListTile(
                          dense: true,
                          title: Text(u.name),
                          subtitle: Text(u.email),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        this.playerController.text =
                            (suggestion as UserRequest).name;
                        this.chosen = suggestion.id;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Teeboxes(
                        tees: this.tees,
                        chosenIndex: chosenIndex,
                        highlight: Colors.white,
                        hide: Theme.of(context).colorScheme.surface,
                        onTap: (t) {
                          setState(() {
                            this.chosenIndex = t;
                          });
                        }),
                    Row(
                      children: [
                        ElevatedButton(
                          child: Text('Verwijder'),
                          onPressed: () {
                            this.returnedFriend(null);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.error),
                        ),
                        Spacer(),
                        ElevatedButton(
                          child: Text('Toevoegen'),
                          onPressed: () {
                            if (this.chosen == "" || this.chosenIndex == -1) {
                              setState(() {
                                this.errorValue =
                                    "Geen teebox of vriend geselecteerd!";
                              });
                              Future.delayed(Duration(seconds: 5), () {
                                setState(() {
                                  this.errorValue = "";
                                });
                              });
                              return;
                            }
                            this.returnedFriend(new Friend(
                                playerController.text,
                                chosenIndex.toDouble(),
                                this.chosen,
                                ''));
                            Navigator.of(context).pop();
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void retrieveFriends() async {
    http
        .get(Uri.parse(AppUtils.apiUrl + "friend/all"),
            headers: await AppUtils.getHeaders())
        .then((value) {
      Map<String, dynamic> response = jsonDecode(value.body);
      if (response['error'] == null) {
        print(this.selectedFriends);
        List<dynamic>.from(response['friends']).forEach((e) {
          dynamic o = e;
          try {
            Friend? f = this.selectedFriends.firstWhere((element) {
              if (element == null) return false;
              print(element.id);
              print(e['id']);
              return element.id == e['id'];
            });
            print(f);
          } catch (e) {
            print(e);
            this.friends.add(UserRequest(o['name'], o['email'], o['id']));
          }
        });
        setState(() {});
      }
    });
  }

  List<UserRequest> filterSearch(String pattern) {
    List<UserRequest> returnedFriends = [];
    this.friends.forEach((element) {
      if (element.name.contains(pattern) || element.email.contains(pattern))
        returnedFriends.add(element);
    });

    return returnedFriends;
  }
}
