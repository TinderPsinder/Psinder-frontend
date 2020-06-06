import 'package:psinder/models/dog.dart';
import 'package:psinder/services/cards_service.dart';

class CardsServiceMock implements CardsService {
  @override
  Future<List<Dog>> fetchDogs() async {
    await Future.delayed(Duration(seconds: 1));

    return Dog.mocks;
  }
}
