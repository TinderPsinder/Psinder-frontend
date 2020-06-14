import 'package:psinder/models/location.dart';
import 'package:psinder/services/maps_service.dart';

class MapsServiceMock implements MapsService {
  @override
  Future<List<Location>> fetchLocations() async {
    await Future.delayed(Duration(seconds: 1));

    return Location.mocks;
  }
}
