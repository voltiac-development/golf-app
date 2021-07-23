import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/roundInformation/playercard.dart';
import 'package:golfcaddie/env.dart';

class RoundInfo extends StatefulWidget {
  RoundInfo({Key? key}) : super(key: key);

  @override
  _RoundInfoState createState() => _RoundInfoState();
}

class _RoundInfoState extends State<RoundInfo> {
  final TextStyle annotation = TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w100);
  final TextStyle leading = TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.normal);
  final TextStyle title = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
  );
  bool callMade = false;
  dynamic roundInformation = {};
  final List<Map<String, dynamic>> playerKeys = [
    {'name': 'playerOne', 'tee': 'teeOne', 'handicap': 'oneHandicap', 'number': Icons.looks_one_outlined},
    {'name': 'playerTwo', 'tee': 'teeTwo', 'handicap': 'twoHandicap', 'number': Icons.looks_two_outlined},
    {'name': 'playerThree', 'tee': 'teeThree', 'handicap': 'threeHandicap', 'number': Icons.looks_3_outlined},
    {'name': 'playerFour', 'tee': 'teeFour', 'handicap': 'fourHandicap', 'number': Icons.looks_4_outlined}
  ];

  List<Map<String, String>> gameInformation = [
    {'leading': "holes", 'title': "N.T.B."},
    {'leading': 'qualifying', 'title': 'Ja'},
    {'leading': 'starttijd', 'title': '22-07-2021 99:99'},
  ];

  List<Map<String, String>> scoreInformation = [
    {'leading': "baanhandicap", 'title': "69"},
    {'leading': 'stableford (punten)', 'title': '20'},
    {'leading': 'totaal slagen', 'title': '52'},
  ];

  final List<Color?> colors = [Colors.grey[300], Colors.lightBlue, Colors.yellow, Colors.red, Colors.orange];

  @override
  Widget build(BuildContext context) {
    if (!callMade) {
      retrieveInformation(ModalRoute.of(context)!.settings.arguments as String);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: DefaultAppBar(title: "SCORE INFORMATIE", person: true, back: true),
      body: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Center(
            child: !this.callMade
                ? new CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface,
                  )
                : Column(children: [
                    Text(
                      'golfbaan',
                      style: annotation,
                    ),
                    Text(
                      roundInformation['courseName'].toString().toUpperCase(),
                      style: title,
                    ),
                    Padding(
                      padding: EdgeInsets.all(3),
                    ),
                    Text(
                      'spelers',
                      style: annotation,
                    ),
                    ...this.playerKeys.map(
                      (e) {
                        if (roundInformation[e['name']] != null) {
                          return PlayerCard(roundInformation: roundInformation, name: e['name']!, tee: e['tee']!, handicap: e['handicap']!, number: e['number']!);
                        }
                        return SizedBox();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      'spelinformatie',
                      style: annotation,
                    ),
                    Padding(
                      padding: EdgeInsets.all(3),
                    ),
                    SizedBox(
                      height: 150,
                      width: 250,
                      child: ListView(
                        children: <Widget>[
                          for (int i = 0; i < this.gameInformation.length; i++)
                            Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  leading: Text(
                                    this.gameInformation[i]['leading']!,
                                    style: leading,
                                    textAlign: TextAlign.left,
                                  ),
                                  title: Text(
                                    this.gameInformation[i]['title']!,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                i != this.gameInformation.length - 1
                                    ? Divider(
                                        height: 5,
                                      )
                                    : SizedBox()
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      'score informatie',
                      style: annotation,
                    ),
                    Padding(
                      padding: EdgeInsets.all(3),
                    ),
                    SizedBox(
                      height: 150,
                      width: 250,
                      child: ListView(
                        children: <Widget>[
                          for (int i = 0; i < this.scoreInformation.length; i++)
                            Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  leading: Text(
                                    this.scoreInformation[i]['leading']!,
                                    style: leading,
                                    textAlign: TextAlign.left,
                                  ),
                                  title: Text(
                                    this.scoreInformation[i]['title']!,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                i != this.scoreInformation.length - 1
                                    ? Divider(
                                        height: 5,
                                      )
                                    : SizedBox()
                              ],
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.secondary),
                        onPressed: () => goToScore(context),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: SizedBox(
                              width: 124,
                              child: Row(
                                children: [
                                  Text('Score bekijken'),
                                  Padding(
                                    padding: EdgeInsets.only(right: 5, left: 5),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                ],
                              ),
                            )))
                  ])),
      ),
    );
  }

  void retrieveInformation(id) async {
    Map<String, String> headers = await AppUtils.getHeaders();
    Dio dio = Dio();
    dio.get(AppUtils.apiUrl + "round/" + id, options: Options(headers: headers)).then((value) {
      this.roundInformation = value.data;
      this.callMade = true;
      print(value.data);
      DateTime date = DateTime.parse(value.data['startsAt'] as String);
      this.gameInformation[0]['title'] = this.roundInformation['holeTypeId'];
      this.gameInformation[1]['title'] = this.roundInformation['qualifying'] == 1 ? "Ja" : "Nee";
      this.gameInformation[2]['title'] =
          date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString() + " (" + date.hour.toString() + ":" + date.minute.toString() + ")";
      setState(() {});
    });
  }

  void goToScore(context) {}
}
