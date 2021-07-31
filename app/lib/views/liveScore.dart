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

  List<int> si = new List.filled(18, -1);
  List<int> par = new List.filled(18, -1);
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

  int holes = 18;

  List<int> white = [];
  List<int> blue = [];
  List<int> yellow = [];
  List<int> red = [];
  List<int> orange = [];

  _LiveScoreScreenState();
  @override
  Widget build(BuildContext context) {
    if (!callMade) {
      startSocket(ModalRoute.of(context)!.settings.arguments as String);
      retrieveCourseInformation(ModalRoute.of(context)!.settings.arguments);
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
                                      CourseInfoHeader(
                                        white: this.white.length > 0,
                                        blue: this.blue.length > 0,
                                        yellow: this.yellow.length > 0,
                                        red: this.red.length > 0,
                                        orange: this.orange.length > 0,
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                            CourseInfo(white: this.white, blue: this.blue, yellow: this.yellow, red: this.red, orange: this.orange, holes: this.holes),
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
                                        Padding(
                                          padding: EdgeInsets.all(2.5),
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

  void retrieveCourseInformation(id) async {
    Dio dio = await AppUtils.getDio();
    Response<dynamic> courseInformation = await dio.get('/round/' + id);
    dio.get('/course/length/' + courseInformation.data['courseId']).then((value) {
      this.white = new List<int>.from(value.data['white']);
      this.blue = new List<int>.from(value.data['blue']);
      this.yellow = new List<int>.from(value.data['yellow']);
      this.red = new List<int>.from(value.data['red']);
      this.orange = new List<int>.from(value.data['orange']);
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
    dio.get('/course/hole/' + courseInformation.data['courseId']).then((value) {
      for (int i = 0; i < value.data.length; i++) {
        this.si[value.data[i]['hole'] - 1] = value.data[i]['si'];
        this.par[value.data[i]['hole'] - 1] = value.data[i]['par'];
      }
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
}
