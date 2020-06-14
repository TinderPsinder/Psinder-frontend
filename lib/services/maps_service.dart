import 'package:meta/meta.dart';
import 'package:psinder/main.dart';
import 'package:psinder/models/location.dart';
import 'package:psinder/services/mock/maps_service_mock.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_service.dart';

abstract class MapsService {
  factory MapsService.build() => isTesting
      ? MapsServiceMock()
      : MapsServiceImpl(
          networkService: NetworkService.build(),
        );

  Future<List<Location>> fetchLocations();
}

class MapsServiceImpl implements MapsService {
  MapsServiceImpl({
    @required NetworkService networkService,
  })  : assert(networkService != null),
        _networkService = networkService;

  final NetworkService _networkService;

  @override
  Future<List<Location>> fetchLocations() async {
    try {
      await _networkService.request(
        NetworkRequest(
          method: NetworkMethod.get,
          endpoint: 'maps/locations',
        ),
      );
    } catch (_) {}

    return Location.mocks;
  }
}
