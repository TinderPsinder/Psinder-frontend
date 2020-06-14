import 'package:meta/meta.dart';
import 'package:psinder/main.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/models/likes.dart';
import 'package:psinder/services/mock/cards_service_mock.dart';
import 'package:psinder/services/network_service/network_method.dart';
import 'package:psinder/services/network_service/network_request.dart';
import 'package:psinder/services/network_service/network_service.dart';

abstract class CardsService {
  factory CardsService.build() => isTesting
      ? CardsServiceMock()
      : CardsServiceImpl(
          networkService: NetworkService.build(),
        );

  Future<List<Dog>> fetchDogs();
  Future<Likes> fetchLikes();
  Future<void> like(Dog dog);
  Future<void> dislike(Dog dog);
}

class CardsServiceImpl implements CardsService {
  CardsServiceImpl({
    @required NetworkService networkService,
  })  : assert(networkService != null),
        _networkService = networkService;

  final NetworkService _networkService;

  @override
  Future<List<Dog>> fetchDogs() async {
    try {
      await _networkService.request(
        NetworkRequest(
          method: NetworkMethod.get,
          endpoint: 'cards/dogs',
        ),
      );
    } catch (_) {}

    return Dog.mocks;
  }

  @override
  Future<Likes> fetchLikes() async {
    try {
      await _networkService.request(
        NetworkRequest(
          method: NetworkMethod.get,
          endpoint: 'cards/likes',
        ),
      );
    } catch (_) {}

    // TODO: implement
    return Likes(liked: [], disliked: []);
  }

  @override
  Future<void> like(Dog dog) async {
    try {
      await _networkService.request(
        NetworkRequest(
          method: NetworkMethod.post,
          endpoint: 'cards/like/${dog.id}',
        ),
      );
    } catch (_) {}
  }

  @override
  Future<void> dislike(Dog dog) async {
    try {
      await _networkService.request(
        NetworkRequest(
          method: NetworkMethod.post,
          endpoint: 'cards/dislike/${dog.id}',
        ),
      );
    } catch (_) {}
  }
}
