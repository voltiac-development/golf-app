import 'package:flutter/material.dart';

class HoleCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final ValueChanged<String> onTap;
  HoleCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onTap(this.title),
      child: Row(
        children: [
          Container(
              height: 50,
              width: 75,
              decoration: this.isSelected
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(width: 2, color: Colors.black))
                  : BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Theme.of(context).colorScheme.surface),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  this.title,
                  style: TextStyle(color: Colors.white),
                ),
              ))),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
