import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/score/courseInfoHeader.dart';
import 'package:golfcaddie/components/score/courseInformation.dart';
import 'package:golfcaddie/components/score/sendScore.dart';
import 'package:golfcaddie/components/score/table.dart';
import 'package:golfcaddie/components/score/tableHeader.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/models/Friend.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class LiveScoreScreen extends StatefulWidget {
  LiveScoreScreen({Key? key}) : super(key: key);

  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  String? roundId;
  bool callMade = false;
  List<Friend> players = [
    Friend('Bart Vermeulen', 39.9, '', ''),
    Friend('Maartje Vermeulen', 39.9, '', ''),
    Friend('Olivier Boekestijn', 39.9, '', ''),
    Friend('Godelieve Boekestijn', 39.9, '', ''),
  ];
  List<IconData> icons = [Icons.looks_one_outlined, Icons.looks_two_outlined, Icons.looks_3_outlined, Icons.looks_4_outlined];
  late io.Socket socket;

  List<List<int>> scores = [
    new List.filled(18, 0),
    new List.filled(18, 0),
    new List.filled(18, 0),
    new List.filled(18, 0),
  ];

  List<int> si = [11, 9, 7, 15, 3, 1, 5, 17, 13, 11, 9, 7, 15, 3, 1, 5, 17, 13];
  List<int> par = [5, 3, 4, 3, 4, 4, 4, 4, 5, 5, 3, 4, 3, 4, 4, 4, 4, 5];
  List<List<int>> holePhc = [
    new List.filled(18, 2),
    new List.filled(18, 2),
    new List.filled(18, 2),
    new List.filled(18, 2),
  ];
  List<List<int?>> strokes = [
    new List.filled(18, null),
    new List.filled(18, null),
    new List.filled(18, null),
    new List.filled(18, null),
  ];

  _LiveScoreScreenState();
  @override
  Widget build(BuildContext context) {
    if (!callMade) {
      startSocket(ModalRoute.of(context)!.settings.arguments as String);
    }

    return DefaultTabController(
        length: players.length + 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: DefaultAppBar(
              title: "RONDE " + DateTime.now().day.toString().padLeft(2, '0') + "-" + DateTime.now().month.toString().padLeft(2, '0'), person: true, back: true),
          body: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                child: Center(
                    child: !this.callMade
                        ? new CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.surface,
                          )
                        : Column(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: TabBar(
                                      isScrollable: true,
                                      indicatorColor: Theme.of(context).colorScheme.surface,
                                      tabs: [
                                        Tab(
                                            child: Text(
                                              'baan',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            icon: Icon(
                                              Icons.sports_golf_outlined,
                                              color: Colors.black,
                                            )),
                                        for (int i = 0; i < players.length; i++)
                                          Tab(
                                              child: Text(
                                                players[i].name.split(' ')[0].toLowerCase(),
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              icon: Icon(
                                                icons[i],
                                                color: Colors.black,
                                              )),
                                        Tab(
                                            child: Text(
                                              'versturen',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            icon: Icon(
                                              Icons.navigate_next_outlined,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                child: TabBarView(children: [
                                  Column(
                                    children: [
                                      CourseInfoHeader(),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                            CourseInfo(),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  for (int i = 0; i < players.length; i++)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TableHeader(),
                                        Expanded(
                                            child: ListView(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 15, bottom: 15),
                                              child: ScoreTable(
                                                holePhc: this.holePhc[i],
                                                par: this.par,
                                                strokes: this.strokes[i],
                                                score: scores[i],
                                                si: this.si,
                                                onScoreChanged: (value) => setState(() {
                                                  this.strokes[i][value[0]] = value[0] == -1 ? null : value[1];
                                                }),
                                              ),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  SendScoreView(),
                                ]),
                              )
                            ],
                          )),
              )),
        ));
  }

  void startSocket(id) async {
    print(id);
    this.socket = await AppUtils.createSocket(context);
    this.socket.emit('join_game', id);
    this.socket.on('init', (data) => print(data));
    this.callMade = true;

    this.socket.emit('update_score', {'roundId': '9e055a93-c756-498c-93f3-d4e470d31c34'});

    this.socket.on('update', (data) {
      print(data);
      print('UPDATE RECEIVEID');
    });
    setState(() {});
  }

  void retrieveCourseInformation() async {
    Dio dio = await AppUtils.getDio();
    dio.get('/course/').then((value) => print(value.data)).catchError((e) {
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
