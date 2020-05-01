import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class CardsStack extends StatelessWidget {
  CardsStack({@required this.images, this.controller, Key key})
      : assert(images != null),
        super(key: key);

  final List<String> images;
  final CardController controller;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.0,
        child: LayoutBuilder(
          builder: (context, constraints) => TinderSwapCard(
            totalNum: images.length,
            maxWidth: constraints.maxWidth * 1.0,
            maxHeight: constraints.maxHeight * 0.8,
            minWidth: constraints.maxWidth * 0.85,
            minHeight: constraints.maxHeight * 0.75,
            cardBuilder: (context, index) => Card(
              child: Image.asset(
                images[index],
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
