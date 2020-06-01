import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _controller = Completer<GoogleMapController>();
  final _mapStyle = Completer<String>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _mapStyle.complete(rootBundle.loadString('assets/styles/retro.json'));
  }

  @override
  Widget build(BuildContext context) => GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (controller) async {
          _controller.complete(controller);
          await controller.setMapStyle(await _mapStyle.future);
        },
      );
}
