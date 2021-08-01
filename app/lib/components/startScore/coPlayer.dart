import 'package:flutter/material.dart';
import 'package:golfcaddie/components/startScore/coPlayerCard.dart';
import 'package:golfcaddie/viewmodels/Friend.dart';
import 'package:golfcaddie/vendor/heroDialogRoute.dart';

class CoPlayer extends StatefulWidget {
  final String tees;
  CoPlayer({Key? key, required this.tees, required this.callback}) : super(key: key);
  final Function(List<dynamic>) callback;

  @override
  _CoPlayerState createState() {
    return _CoPlayerState(t: this.tees, callback: this.callback);
  }
}

class _CoPlayerState extends State<CoPlayer> {
  String t;
  final TextStyle annotation = TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w100);

  Function(List<dynamic>) callback;

  List<Friend?> players = [null, null, null];
  List<int> tees = [-1, -1, -1];
  List<IconData> iconPlayers = [Icons.looks_one_outlined, Icons.looks_two_outlined, Icons.looks_3_outlined];

  _CoPlayerState({required this.t, required this.callback});

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
                          color: this.players[i] == null ? Theme.of(context).colorScheme.surface : Colors.greenAccent,
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
                                    this.callback([this.players, this.tees]);
                                  },
                                  chosenTee: (value) {
                                    if (this.tees.length == 3)
                                      this.tees[i] = value;
                                    else
                                      this.tees[i + 1] = value;
                                    this.callback([this.players, this.tees]);
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
