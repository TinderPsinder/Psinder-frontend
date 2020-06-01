import 'package:flutter/material.dart';

Widget buildImageLoader(
  BuildContext context,
  Widget child,
  ImageChunkEvent loadingProgress,
) =>
    loadingProgress == null
        ? child
        : Container(
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            padding: EdgeInsets.all(36.0),
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );

Widget buildImageError(
  BuildContext context,
  Object exception,
  StackTrace stackTrace,
) =>
    Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Icon(
        Icons.error,
        size: 32.0,
        color: Colors.grey.shade400,
      ),
    );
