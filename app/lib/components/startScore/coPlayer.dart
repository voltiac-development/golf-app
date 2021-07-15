import 'package:flutter/material.dart';
import 'package:flutter_golf/components/personalCard/customAnimation.dart';
import 'package:flutter_golf/components/startScore/teeBoxes.dart';
import 'package:flutter_golf/models/Friend.dart';
import 'package:flutter_golf/vendor/heroDialogRoute.dart';

class CoPlayer extends StatefulWidget {
  CoPlayer({Key? key}) : super(key: key);

  @override
  _CoPlayerState createState() => _CoPlayerState();
}

class _CoPlayerState extends State<CoPlayer> {
  final TextStyle annotation =
      TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w100);

  List<Friend?> players = [null, null, null];
  List<IconData> iconPlayers = [
    Icons.looks_one_outlined,
    Icons.looks_two_outlined,
    Icons.looks_3_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'mede spelers',
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
                                child: CoPlayerCard(id: i),
                              ),
                            ),
                          );
                          setState(() {
                            this.players[i] = new Friend(
                                'Bart Vermeulen', 29.9, 'f', 'image');
                          });
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
  CoPlayerCard({Key? key, required this.id}) : super(key: key);

  @override
  _CoPlayerCardState createState() => _CoPlayerCardState(id: this.id);
}

class _CoPlayerCardState extends State<CoPlayerCard> {
  final int id;
  _CoPlayerCardState({required this.id});

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TeeBoxes(
                      tees: '',
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
