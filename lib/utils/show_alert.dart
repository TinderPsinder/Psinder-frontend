import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showAlert(
  BuildContext context, {
  String content,
  VoidCallback onOk,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(tr('alert.title')),
        content: Text(content ?? ''),
        actions: <Widget>[
          FlatButton(
            child: Text(tr('alert.ok')),
            onPressed: () {
              Navigator.pop(context);

              if (onOk != null) {
                onOk();
              }
            },
          ),
        ],
      ),
    );
