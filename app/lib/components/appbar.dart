import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar = AppBar();
  final bool person;
  final bool back;

  /// you can add more fields that meet your needs

  DefaultAppBar(
      {Key? key, required this.title, required this.person, required this.back})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Color(0xFFffffff),
        disabledColor: Theme.of(context).primaryColor,
        tooltip: 'Terug',
        onPressed: this.back
            ? () {
                Navigator.of(context).pop();
              }
            : null,
      ),
      title: Center(
          child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w200, color: Color(0xFFffffff)),
      )),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: IconButton(
            icon: const Icon(Icons.person_outline),
            color: Color(0xFFffffff),
            disabledColor: Theme.of(context).primaryColor,
            tooltip: 'Account',
            onPressed: this.person
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account tonen')));
                  }
                : null,
          ),
        ),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
