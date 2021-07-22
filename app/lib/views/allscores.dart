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
          decoration: BoxDecoration(color: Color(0xFFffffff), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...this.rounds.map((e) => Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed('roundinfo', arguments: e['roundId']),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.black45, offset: Offset.fromDirection(1), blurRadius: 2)],
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(12)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.76,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Text(Day.fromString(e['startsAt']).format('DD-MM-YYYY'),
                                      style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  getIconForPlayers(e)
                                ],
                              ),
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
    Dio dio = Dio();
    Map<String, String> headers = await AppUtils.getHeaders();
    dio.get(AppUtils.apiUrl + "round/recent", options: Options(headers: headers, responseType: ResponseType.json)).then((value) {
      setState(() {
        this.rounds = value.data['rounds'];
      });
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
