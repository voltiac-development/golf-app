import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/score/courseInfoHeader.dart';
import 'package:golfcaddie/components/score/courseInformation.dart';
import 'package:golfcaddie/components/score/sendScore.dart';
import 'package:golfcaddie/components/score/table.dart';
import 'package:golfcaddie/components/score/tableHeader.dart';
import 'package:golfcaddie/logic/liveScoreManager.dart';
import 'package:golfcaddie/models/livescore.dart';

class LiveScoreScreen extends StatefulWidget {
  LiveScoreScreen({Key? key}) : super(key: key);
  @override
  _LiveScoreScreenState createState() => _LiveScoreScreenState();
}

class _LiveScoreScreenState extends State<LiveScoreScreen> {
  bool callMade = false;
  List<IconData> icons = [Icons.looks_one_outlined, Icons.looks_two_outlined, Icons.looks_3_outlined, Icons.looks_4_outlined];
  LiveScoreManager manager = new LiveScoreManager();
  LiveScore model = new LiveScore();

  @override
  Widget build(BuildContext context) {
    if (!this.callMade) {
      ModalRoute.of(context)!.settings.arguments as String;
      delayedFunction(ModalRoute.of(context)!.settings.arguments, context);
    }

    return DefaultTabController(
        length: this.model.players.length + 2,
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
                                        for (int i = 0; i < this.model.players.length; i++)
                                          Tab(
                                              child: Text(
                                                this.model.players[i].name.split(' ')[0].toLowerCase(),
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              icon: Icon(
                                                this.icons[i],
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
                                      Padding(
                                        padding: EdgeInsets.all(2.5),
                                      ),
                                      CourseInfoHeader(
                                        white: this.model.white.length > 0,
                                        blue: this.model.blue.length > 0,
                                        yellow: this.model.yellow.length > 0,
                                        red: this.model.red.length > 0,
                                        orange: this.model.orange.length > 0,
                                      ),
                                      Expanded(
                                        child: ListView(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                            CourseInfo(
                                                white: this.model.white,
                                                blue: this.model.blue,
                                                yellow: this.model.yellow,
                                                red: this.model.red,
                                                orange: this.model.orange,
                                                holes: this.model.holes),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  for (int i = 0; i < this.model.players.length; i++)
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
                                                holePhc: this.model.holePhc[i],
                                                par: this.model.par,
                                                strokes: this.model.strokes[i],
                                                score: this.model.scores[i],
                                                si: this.model.si,
                                                onScoreChanged: (value) => setState(() {
                                                  this.model.strokes[i][value[0]] = value[0] == -1 ? null : value[1];
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

  void delayedFunction(id, context) async {
    await manager.startSocket(id, context).then((v) => {
          manager.retrieveCourseInformation(id, context).then((model) {
            this.model = model;
            this.callMade = true;
            setState(() {});
          })
        });
  }
}
