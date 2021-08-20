import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:day/day.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/components/appbar.dart';
import 'package:golfcaddie/components/startScore/holeContainer.dart';
import 'package:golfcaddie/env.dart';
import 'package:golfcaddie/logic/courseInformation.dart';
import 'package:golfcaddie/viewmodels/CourseInformation.dart';
import 'package:golfcaddie/viewmodels/Friend.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseInformation extends StatefulWidget {
  CourseInformation({Key? key}) : super(key: key);

  @override
  _CourseInformationState createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation> {
  List<String> days = ["Maandag", "Dinsdag", "Woensdag", 'Donderdag', "Vrijdag", "Zaterdag", "Zondag"];
  bool callMade = false;
  Friend friend = new Friend('Bart Vermeulen', 2.3, '', '', '1');
  List<dynamic> rounds = [];
  CourseInfoManager manager = CourseInfoManager();
  CourseInfo model = new CourseInfo();

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)!.settings.arguments);
    if (!callMade) createAsyncCall(ModalRoute.of(context)!.settings.arguments as String);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: DefaultAppBar(
        back: true,
        person: true,
        title: "GOLFBAAN",
      ),
      body: SingleChildScrollView(
          child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Center(
            child: !this.callMade
                ? new CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.surface,
                  )
                : Column(children: [
                    ColumnSuper(
                      children: [
                        Container(
                          decoration: BoxDecoration(boxShadow: [BoxShadow(offset: Offset(1, 1), color: Colors.black26, blurRadius: 15)]),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child:
                                Image.network(this.model.background, fit: BoxFit.cover, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image.network('https://cdn.bartverm.dev/golfcaddie/util/profile_background.jpg', fit: BoxFit.cover);
                            }),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [BoxShadow(offset: Offset(-1, -1), color: Colors.black12, blurRadius: 15)]),
                          child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: Image.network(
                                  this.model.getImage,
                                  width: 100,
                                  height: 100,
                                ),
                              )),
                        )
                      ],
                      innerDistance: -50,
                    ),
                    Text(
                      this.model.getName,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      "beschikbare afslagplaatsen",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      this.model.teeBoxes.contains('WHITE')
                          ? Icon(
                              Icons.sports_golf_outlined,
                              size: 40,
                              color: Colors.grey[300],
                            )
                          : SizedBox(),
                      this.model.teeBoxes.contains('BLUE') ? Icon(Icons.sports_golf_outlined, size: 40, color: Colors.lightBlue) : SizedBox(),
                      this.model.teeBoxes.contains('YELLOW')
                          ? Icon(
                              Icons.sports_golf_outlined,
                              size: 40,
                              color: Colors.yellow,
                            )
                          : SizedBox(),
                      this.model.teeBoxes.contains('RED')
                          ? Icon(
                              Icons.sports_golf_outlined,
                              size: 40,
                              color: Colors.red,
                            )
                          : SizedBox(),
                      this.model.teeBoxes.contains('ORANGE')
                          ? Icon(
                              Icons.sports_golf_outlined,
                              size: 40,
                              color: Colors.orange,
                            )
                          : SizedBox()
                    ]),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      "uw recente rondes",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    ...this
                        .model
                        .rounds
                        .map((e) => Column(
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
                                    child: Padding(
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
                                                ],
                                              ),
                                              Spacer(),
                                              getIconForPlayers(e)
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(2))
                              ],
                            ))
                        .toList(),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      "ronde mogelijkheden",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...this.model.roundTypes.map((e) => HoleCard(title: e['roundVariation'], onTap: (t) => {}, isSelected: false)).toList(),
                            ],
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Text(
                      "openingstijden",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2),
                    ),
                    ...this.model.openingHours.map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(this.days[int.parse(e['day'])]),
                            Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                '|',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                              ),
                            ),
                            e['open'] == "-"
                                ? Text(
                                    'Gesloten',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : Text((e['open'] ?? "Zonsopgang") + " - " + (e['close'] ?? "Zonsondergang"))
                          ],
                        )),
                    Padding(padding: EdgeInsets.all(2)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.primary),
                        onPressed: () => openWebsite(this.model.website, context),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            'Naar website',
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        )),
                    Padding(padding: EdgeInsets.all(15))
                  ])),
      )),
    );
  }

  void createAsyncCall(id) async {
    await manager.retrieveCourseInformation(id);
    await manager.retrieveBusinessHours(id);
    this.model = await manager.retrieveRecentRounds(id);
    this.callMade = true;
    setState(() {});
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

  void openWebsite(url, context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      AppUtils.callSnackbar(context, 'De website \"' + url + "\" kan niet geopend worden.");
    }
  }
}
