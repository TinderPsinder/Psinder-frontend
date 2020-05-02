import 'package:meta/meta.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_service.dart';

abstract class CardsService {
  factory CardsService.build() => CardsServiceImpl(
        networkService: NetworkService.build(),
      );

  Future<List<String>> fetchCards();
}

class CardsServiceImpl implements CardsService {
  CardsServiceImpl({
    @required NetworkService networkService,
  })  : assert(networkService != null),
        _networkService = networkService;

  final NetworkService _networkService;

  Future<List<String>> fetchCards() async {
    try {
      await _networkService.request(
        NetworkRequest(
          method: NetworkMethod.get,
          endpoint: 'cards/dogs',
        ),
      );
    } catch (_) {}

    return [
      'assets/images/jamnik1.jpg',
      'assets/images/jamnik2.jpg',
      'assets/images/jamnik3.jpg',
      'assets/images/jamnik4.jpg',
      'assets/images/jamnik5.jpg',
      'assets/images/jamnik6.jpg',
    ];
  }
}
