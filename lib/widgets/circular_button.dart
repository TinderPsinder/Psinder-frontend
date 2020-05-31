import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    this.color,
    this.icon,
    this.compact = false,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final bool compact;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => MaterialButton(
        onPressed: onPressed,
        color: color,
        textColor: Colors.white,
        child: Icon(icon, size: compact ? 16.0 : 24.0),
        padding: compact ? null : EdgeInsets.all(16.0),
        shape: CircleBorder(),
        visualDensity: compact ? VisualDensity.compact : null,
        minWidth: 0.0,
      );
}
