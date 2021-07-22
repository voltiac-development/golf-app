import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:golfcaddie/components/personalCard/popupcard.dart';
import 'package:golfcaddie/vendor/heroDialogRoute.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar = AppBar();
  final bool person;
  final bool back;

  /// you can add more fields that meet your needs

  DefaultAppBar({Key? key, required this.title, required this.person, required this.back}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      leading: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Color(0xFFffffff),
          disabledColor: Theme.of(context).colorScheme.primary,
          tooltip: 'Terug',
          onPressed: this.back
              ? () {
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ),
      title: Center(
          child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w200, color: Color(0xFFffffff)),
      )),
      actions: <Widget>[
        Hero(
            tag: 'profile_edit',
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(Icons.person_outline),
                  color: Color(0xFFffffff),
                  disabledColor: Theme.of(context).colorScheme.primary,
                  tooltip: 'Account',
                  onPressed: this.person
                      ? () {
                          Navigator.of(context).push(
                            HeroDialogRoute(
                              builder: (context) => Center(
                                child: PopupCard(),
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ),
            )),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
