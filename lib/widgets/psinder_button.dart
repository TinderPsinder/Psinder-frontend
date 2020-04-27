import 'package:flutter/material.dart';

class PsinderButton extends StatelessWidget {
  const PsinderButton({
    this.text,
    this.isFlat = false,
    this.onPressed,
    Key key,
  })  : assert(isFlat != null),
        super(key: key);

  final String text;
  final bool isFlat;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FlatButton(
        color: isFlat ? null : Colors.grey.shade300,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        padding: EdgeInsets.all(12.0),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      );
}
