import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({@required ImageProvider image, Key key})
      : assert(image != null),
        _image = image,
        super(key: key);

  factory PhotoPage.build({@required ImageProvider image}) =>
      PhotoPage(image: image);

  final ImageProvider _image;

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: PhotoView(
          imageProvider: widget._image,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          minScale: PhotoViewComputedScale.contained,
          filterQuality: FilterQuality.low,
        ),
      );
}
