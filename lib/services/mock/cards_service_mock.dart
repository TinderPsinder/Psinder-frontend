import 'package:psinder/models/dog.dart';
import 'package:psinder/models/likes.dart';
import 'package:psinder/services/cards_service.dart';

class CardsServiceMock implements CardsService {
  static final _likes = <int, bool>{};

  @override
  Future<List<Dog>> fetchDogs() async {
    await Future.delayed(Duration(seconds: 1));

    return Dog.mocks;
  }

  @override
  Future<Likes> fetchLikes() async {
    await Future.delayed(Duration(seconds: 1));

    return Likes(
      liked: _likes.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key)
          .toList(),
      disliked: _likes.entries
          .where((entry) => entry.value == false)
          .map((entry) => entry.key)
          .toList(),
    );
  }

  @override
  Future<void> like(Dog dog) async {
    await Future.delayed(Duration(seconds: 1));

    _likes[dog.id] = true;
  }

  @override
  Future<void> dislike(Dog dog) async {
    await Future.delayed(Duration(seconds: 1));

    _likes[dog.id] = false;
  }
}
