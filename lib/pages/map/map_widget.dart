import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({this.markers, Key key}) : super(key: key);

  final Set<Marker> markers;

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _controller = Completer<GoogleMapController>();
  final _mapStyle = Completer<String>();

  @override
  void initState() {
    super.initState();

    _mapStyle.complete(rootBundle.loadString('assets/styles/retro.json'));
  }

  @override
  Widget build(BuildContext context) => GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(51.1065, 17.0197),
          zoom: 11.0,
        ),
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        tiltGesturesEnabled: false,
        myLocationEnabled: true,
        markers: widget.markers,
        onMapCreated: (controller) async {
          _controller.complete(controller);
          await controller.setMapStyle(await _mapStyle.future);
        },
      );
}
