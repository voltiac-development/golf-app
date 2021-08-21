import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/viewmodels/Friend.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:golfcaddie/components/personalCard/customAnimation.dart';
import 'package:golfcaddie/components/startScore/teeBoxes.dart';

class CoPlayerCard extends StatefulWidget {
  final int id;
  final String tees;
  final ValueChanged<Friend?> returnedFriend;
  final ValueChanged<int> chosenTee;
  final Friend? friend;
  final List<Friend?> selectedFriends;
  CoPlayerCard(
      {Key? key, required this.id, required this.tees, required this.returnedFriend, required this.friend, required this.selectedFriends, required this.chosenTee})
      : super(key: key);

  @override
  _CoPlayerCardState createState() {
    return _CoPlayerCardState(
        id: this.id, tees: this.tees, returnedFriend: this.returnedFriend, friend: this.friend, selectedFriends: this.selectedFriends, teeCallback: this.chosenTee);
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
  ValueChanged<int> teeCallback;
  TextEditingController playerController = new TextEditingController();
  _CoPlayerCardState(
      {required this.id, required this.tees, required this.returnedFriend, required this.friend, required this.selectedFriends, required this.teeCallback}) {
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
            height: MediaQuery.of(context).size.height < 350 ? MediaQuery.of(context).size.height : 350,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Mede-speler kiezen',
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      child: Text(this.errorValue, style: TextStyle(color: Colors.red)),
                      height: this.errorValue == "" ? 0 : 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    TypeAheadField(
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(color: Theme.of(context).colorScheme.surface),
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: playerController,
                          decoration: InputDecoration(
                            fillColor: Theme.of(context).colorScheme.surface,
                            isDense: true,
                            focusColor: Theme.of(context).colorScheme.primary,
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
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
                          title: Text(
                            u.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(u.email, style: TextStyle(color: Colors.white70)),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        this.playerController.text = (suggestion as UserRequest).name;
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
                            this.teeCallback(-1);
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.error),
                        ),
                        Spacer(),
                        ElevatedButton(
                          child: Text('Toevoegen'),
                          onPressed: () {
                            if (this.chosen == "" || this.chosenIndex == -1) {
                              setState(() {
                                this.errorValue = "Geen teebox of vriend geselecteerd!";
                              });
                              Future.delayed(Duration(seconds: 5), () {
                                setState(() {
                                  this.errorValue = "";
                                });
                              });
                              return;
                            }
                            this.teeCallback(this.chosenIndex);
                            this.returnedFriend(new Friend(playerController.text, chosenIndex.toDouble(), this.chosen, '', ''));
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.green),
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
    Dio dio = await AppUtils.getDio();
    dio.get('/friend/all').then((value) {
      List<dynamic>.from(value.data['friends']).forEach((e) {
        dynamic o = e;
        try {
          Friend? f = this.selectedFriends.firstWhere((element) {
            if (element == null) return false;
            return element.id == e['id'];
          });
        } catch (e) {
          this.friends.add(UserRequest(o['name'], o['email'], o['id']));
        }
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

  List<UserRequest> filterSearch(String pattern) {
    List<UserRequest> returnedFriends = [];
    this.friends.forEach((element) {
      if (element.name.contains(pattern) || element.email.contains(pattern)) returnedFriends.add(element);
    });

    return returnedFriends;
  }
}
