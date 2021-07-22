import 'package:flutter/material.dart';

class QualifyingSwitch extends StatelessWidget {
  final bool state;
  final ValueChanged<bool> stateChanged;
  QualifyingSwitch({required this.state, required this.stateChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => this.stateChanged(true),
            child: Container(
                decoration: BoxDecoration(
                    color: this.state ? Color(0xFF166cb5) : Theme.of(context).colorScheme.surface,
                    boxShadow: this.state ? [BoxShadow(color: Colors.black, offset: Offset(1, 0), blurRadius: 2)] : []),
                child: Padding(
                  padding: EdgeInsets.only(left: this.state ? 17 : 15, right: this.state ? 17 : 15, top: this.state ? 7 : 5, bottom: this.state ? 7 : 5),
                  child: Text(
                    'Ja',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                )),
          ),
          GestureDetector(
            onTap: () => this.stateChanged(false),
            child: Container(
                decoration: BoxDecoration(
                    color: !this.state ? Color(0xFF166cb5) : Theme.of(context).colorScheme.surface,
                    boxShadow: !this.state ? [BoxShadow(color: Colors.black, offset: Offset(-1, 0), blurRadius: 2)] : []),
                child: Padding(
                  padding: EdgeInsets.only(left: !this.state ? 17 : 15, right: !this.state ? 17 : 15, top: !this.state ? 7 : 5, bottom: !this.state ? 7 : 5),
                  child: Text(
                    'Nee',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
