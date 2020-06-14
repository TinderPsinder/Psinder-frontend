import 'package:meta/meta.dart';
import 'package:psinder/utils/psinder_exception.dart';
import 'package:xml/xml.dart' as xml;

class Location {
  int id;
  int dogId;
  double lat;
  double lng;

  Location({
    @required this.id,
    @required this.dogId,
    @required this.lat,
    @required this.lng,
  }) {
    if (id == null) throw PsinderException.parse('id');
    if (dogId == null) throw PsinderException.parse('dogId');
    if (lat == null) throw PsinderException.parse('lat');
    if (lng == null) throw PsinderException.parse('lng');
  }

  factory Location.fromXml(String xmlString) {
    final document = xml.parse(xmlString);
    final location = document.findElements('Location').first;

    return Location(
      id: int.parse(location.findElements('id').first.text),
      dogId: int.parse(location.findElements('dogId').first.text),
      lat: double.parse(location.findElements('lat').first.text),
      lng: double.parse(location.findElements('lng').first.text),
    );
  }

  static List<Location> get mocks => [
        Location(
          id: 1,
          dogId: 1,
          lat: 51.101941322841235,
          lng: 17.029650599247347,
        ),
        Location(
          id: 2,
          dogId: 2,
          lat: 51.10536911913704,
          lng: 16.952454856529492,
        ),
        Location(
          id: 3,
          dogId: 3,
          lat: 51.07732487368464,
          lng: 17.040392337107395,
        ),
        Location(
          id: 4,
          dogId: 4,
          lat: 51.06543525671968,
          lng: 17.099497427112393,
        ),
        Location(
          id: 5,
          dogId: 5,
          lat: 51.0731739128804,
          lng: 17.03564382385946,
        ),
        Location(
          id: 6,
          dogId: 6,
          lat: 51.10950676799433,
          lng: 16.982316228291587,
        ),
        Location(
          id: 7,
          dogId: 7,
          lat: 51.09459445442851,
          lng: 17.014951702576006,
        ),
        Location(
          id: 8,
          dogId: 8,
          lat: 51.084548024570694,
          lng: 17.055669935827073,
        ),
        Location(
          id: 9,
          dogId: 9,
          lat: 51.12134085653705,
          lng: 17.007565769736175,
        ),
        Location(
          id: 10,
          dogId: 10,
          lat: 51.13045936557456,
          lng: 16.991534883932896,
        ),
        Location(
          id: 11,
          dogId: 11,
          lat: 51.08148723936979,
          lng: 17.07721549456594,
        ),
        Location(
          id: 12,
          dogId: 12,
          lat: 51.14096369129126,
          lng: 16.962332325015513,
        ),
        Location(
          id: 13,
          dogId: 13,
          lat: 51.131746297959666,
          lng: 17.005420714957246,
        ),
        Location(
          id: 14,
          dogId: 14,
          lat: 51.10748659550451,
          lng: 17.079312530611425,
        ),
        Location(
          id: 15,
          dogId: 15,
          lat: 51.10440739166563,
          lng: 17.09329599125921,
        ),
        Location(
          id: 16,
          dogId: 16,
          lat: 51.12623012437858,
          lng: 17.06148502776835,
        ),
      ];
}
