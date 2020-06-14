import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/models/location.dart';
import 'package:psinder/models/sex.dart';
import 'package:psinder/pages/dog/dog_page.dart';
import 'package:psinder/pages/map/map_widget.dart';
import 'package:psinder/services/cards_service.dart';
import 'package:psinder/services/maps_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    @required CardsService cardsService,
    @required MapsService mapsService,
    Key key,
  })  : assert(cardsService != null),
        assert(mapsService != null),
        _cardsService = cardsService,
        _mapsService = mapsService,
        super(key: key);

  factory MapPage.build() => MapPage(
        cardsService: CardsService.build(),
        mapsService: MapsService.build(),
      );

  final CardsService _cardsService;
  final MapsService _mapsService;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers;

  @override
  void initState() {
    super.initState();

    _fetchCards();
  }

  @override
  Widget build(BuildContext context) => MapWidget(
        markers: _markers,
      );

  Future<void> _fetchCards() async {
    List<Location> locations;
    List<Dog> dogs;

    await Future.wait([
      widget._mapsService.fetchLocations().then((value) => locations = value),
      widget._cardsService.fetchDogs().then((value) => dogs = value),
    ]);

    final markers = locations
        .map((location) {
          final dog = dogs.firstWhere(
            (dog) => dog.id == location.dogId,
            orElse: () => null,
          );

          if (dog != null) {
            return Marker(
              markerId: MarkerId(location.id.toString()),
              position: LatLng(location.lat, location.lng),
              infoWindow: InfoWindow(
                title: '${dog.name}, ${dog.age}',
                snippet: '${dog.sex.toLocalizedString()}, ${dog.breed}',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DogPage.build(dog: dog),
                  ),
                ),
              ),
            );
          } else {
            return null;
          }
        })
        .where((marker) => marker != null)
        .toSet();

    setState(() => _markers = markers);
  }
}
