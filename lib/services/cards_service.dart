import 'package:meta/meta.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/models/sex.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_service.dart';

abstract class CardsService {
  factory CardsService.build() => CardsServiceImpl(
        networkService: NetworkService.build(),
      );

  Future<List<Dog>> fetchDogs();
}

class CardsServiceImpl implements CardsService {
  CardsServiceImpl({
    @required NetworkService networkService,
  })  : assert(networkService != null),
        _networkService = networkService;

  final NetworkService _networkService;

  Future<List<Dog>> fetchDogs() async {
    try {
      await _networkService.request(
        NetworkRequest(
          method: NetworkMethod.get,
          endpoint: 'cards/dogs',
        ),
      );
    } catch (_) {}

    return [
      Dog(
        name: 'Pies',
        breed: 'Jamnik',
        sex: Sex.dog,
        age: 10,
        description:
            'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
        pictures: [
          'assets/images/jamnik1.jpg',
          'assets/images/jamnik2.jpg',
        ],
      ),
      Dog(
        name: 'Pies',
        breed: 'Jamnik',
        sex: Sex.dog,
        age: 10,
        description:
            'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
        pictures: [
          'assets/images/jamnik2.jpg',
        ],
      ),
      Dog(
        name: 'Pies',
        breed: 'Jamnik',
        sex: Sex.dog,
        age: 10,
        description:
            'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
        pictures: [
          'assets/images/jamnik3.jpg',
          'assets/images/jamnik2.jpg',
        ],
      ),
      Dog(
        name: 'Pies',
        breed: 'Jamnik',
        sex: Sex.dog,
        age: 10,
        description:
            'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
        pictures: [
          'assets/images/jamnik4.jpg',
          'assets/images/jamnik2.jpg',
        ],
      ),
      Dog(
        name: 'Pies',
        breed: 'Jamnik',
        sex: Sex.dog,
        age: 10,
        description:
            'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
        pictures: [
          'assets/images/jamnik5.jpg',
          'assets/images/jamnik2.jpg',
        ],
      ),
      Dog(
        name: 'Pies',
        breed: 'Jamnik',
        sex: Sex.dog,
        age: 10,
        description:
            'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
        pictures: [
          'assets/images/jamnik6.jpg',
          'assets/images/jamnik2.jpg',
        ],
      ),
    ];
  }
}
