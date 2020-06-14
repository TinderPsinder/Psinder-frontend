import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/pages/cards/cards_stack.dart';
import 'package:psinder/pages/dog/dog_page.dart';
import 'package:psinder/services/cards_service.dart';
import 'package:psinder/widgets/circular_button.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({@required CardsService cardsService, Key key})
      : assert(cardsService != null),
        _cardsService = cardsService,
        super(key: key);

  factory CardsPage.build() => CardsPage(cardsService: CardsService.build());

  final CardsService _cardsService;

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final _cardController = CardController();

  List<Dog> dogs;

  @override
  void initState() {
    super.initState();

    _fetchCards();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CardsStack(
              images: dogs?.map((dog) => dog.pictures.first)?.toList(),
              controller: _cardController,
              onSwipe: (index, orientation) {
                switch (orientation) {
                  case CardSwipeOrientation.LEFT:
                    widget._cardsService.dislike(dogs[index]);
                    break;

                  case CardSwipeOrientation.RIGHT:
                    widget._cardsService.like(dogs[index]);
                    break;

                  default:
                    break;
                }
              },
              onTap: (index) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DogPage.build(dog: dogs[index]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32.0, bottom: 48.0),
              child: _buildButtonsRow(),
            ),
          ],
        ),
      );

  Widget _buildButtonsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircularButton(
            color: Colors.red,
            icon: Icons.close,
            onPressed: () => _cardController.triggerLeft(),
          ),
          CircularButton(
            color: Colors.green,
            icon: Icons.favorite,
            onPressed: () => _cardController.triggerRight(),
          ),
        ],
      );

  Future<void> _fetchCards() async {
    final dogs = await widget._cardsService.fetchDogs();

    setState(() {
      this.dogs = dogs;
    });
  }
}
