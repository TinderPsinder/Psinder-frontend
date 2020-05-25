import 'package:flutter/material.dart';
import 'package:psinder/pages/map/map_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  factory MapPage.build() => MapPage();

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) => MapWidget();
}
