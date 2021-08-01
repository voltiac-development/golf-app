import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golfcaddie/viewmodels/Friend.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;

  FriendCard({Key? key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 7),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('friend', arguments: this.friend.id),
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
                                this.friend.getImage,
                                height: 45,
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Text(
                                    friend.getName,
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
                              Icons.sports_golf_outlined,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            Text(
                              this.friend.getHandicap.toString(),
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
