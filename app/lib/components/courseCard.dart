import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/viewmodels/CourseInformation.dart';

class CourseCard extends StatelessWidget {
  final CourseInfo info;
  CourseCard({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 7),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('courseInfo', arguments: this.info.getId),
          child: Material(
            child: Container(
                constraints: BoxConstraints(minWidth: 200, maxWidth: 300),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Theme.of(context).colorScheme.secondary, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 3),
                  ),
                ]),
                width: MediaQuery.of(context).size.width * .90,
                height: 45,
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Container(
                              child: new Image.network(
                                this.info.getImage,
                                height: 45,
                                width: 45 / 362 * 325,
                              ),
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Text(
                                    info.getName,
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 17, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.golf_course_outlined,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            Text(
                              this.info.getHoles.toString(),
                              style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
