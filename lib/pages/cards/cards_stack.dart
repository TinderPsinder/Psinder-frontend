import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class CardsStack extends StatelessWidget {
  CardsStack({Key key, this.controller}) : super(key: key);

  final CardController controller;

  final _testImages = [
    "assets/images/jamnik1.jpg",
    "assets/images/jamnik2.jpg",
    "assets/images/jamnik3.jpg",
    "assets/images/jamnik4.jpg",
    "assets/images/jamnik5.jpg",
    "assets/images/jamnik6.jpg",
  ];

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.0,
        child: LayoutBuilder(
          builder: (context, constraints) => TinderSwapCard(
            totalNum: _testImages.length * 100,
            maxWidth: constraints.maxWidth * 1.0,
            maxHeight: constraints.maxHeight * 0.8,
            minWidth: constraints.maxWidth * 0.85,
            minHeight: constraints.maxHeight * 0.75,
            cardBuilder: (context, index) => Card(
              child: Image.asset(
                '${_testImages[index % _testImages.length]}',
                fit: BoxFit.cover,
              ),
            ),
            swipeCompleteCallback: (orientation, index) {
              print(orientation);
            },
            cardController: controller,
          ),
        ),
      );
}
