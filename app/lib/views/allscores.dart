import 'package:day/day.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/env.dart';
import '../components/appbar.dart';

class RecentScores extends StatefulWidget {
  RecentScores({Key? key}) : super(key: key);

  @override
  _RecentScoresState createState() => _RecentScoresState();
}

class _RecentScoresState extends State<RecentScores> {
  List<dynamic> rounds = [];

  _RecentScoresState() {
    getRecentRounds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(title: 'SCORES BEKIJKEN', person: true, back: true),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...this.rounds.map((e) => Column(
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
                    )),
              ],
            ),
          ),
        ));
  }

  void getRecentRounds() async {
    Dio dio = await AppUtils.getDio();
    dio.get("/round/recent").then((value) {
      setState(() {
        this.rounds = value.data['rounds'];
      });
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
