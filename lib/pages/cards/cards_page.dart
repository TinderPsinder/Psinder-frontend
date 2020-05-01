import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:psinder/pages/cards/cards_stack.dart';
import 'package:psinder/services/cards_service.dart';

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

  List<String> images;

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
            if (images != null)
              CardsStack(
                images: images,
                controller: _cardController,
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
          _buildCircularButton(
            color: Colors.red,
            icon: Icons.close,
            onPressed: () => _cardController.triggerLeft(),
          ),
          _buildCircularButton(
            color: Colors.green,
            icon: Icons.favorite,
            onPressed: () => _cardController.triggerRight(),
          ),
        ],
      );

  Widget _buildCircularButton({
    Color color,
    IconData icon,
    void Function() onPressed,
  }) =>
      MaterialButton(
        onPressed: onPressed,
        color: color,
        textColor: Colors.white,
        child: Icon(icon, size: 24.0),
        padding: EdgeInsets.all(16.0),
        shape: CircleBorder(),
      );

  Future<void> _fetchCards() async {
    final cards = await widget._cardsService.fetchCards();

    setState(() {
      images = cards;
    });
  }
}
