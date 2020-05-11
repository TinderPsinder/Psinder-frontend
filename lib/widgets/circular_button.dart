import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    this.color,
    this.icon,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: onPressed,
        color: color,
        textColor: Colors.white,
        child: Icon(icon, size: 24.0),
        padding: EdgeInsets.all(16.0),
        shape: CircleBorder(),
      );
}
