import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class CardsStack extends StatelessWidget {
  CardsStack({
    this.images,
    this.controller,
    this.onSwipe,
    this.onTap,
    Key key,
  }) : super(key: key);

  final List<String> images;
  final CardController controller;
  final Function(int, CardSwipeOrientation) onSwipe;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.0,
        child: images != null
            ? _buildTinder()
            : Center(child: CircularProgressIndicator()),
      );

  Widget _buildTinder() => LayoutBuilder(
        builder: (context, constraints) => TinderSwapCard(
          totalNum: images.length,
          maxWidth: constraints.maxWidth * 1.0,
          maxHeight: constraints.maxHeight * 0.8,
          minWidth: constraints.maxWidth * 0.85,
          minHeight: constraints.maxHeight * 0.75,
          cardBuilder: (context, index) => GestureDetector(
            onTap: () => onTap?.call(index),
            child: Card(
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          swipeCompleteCallback: (orientation, index) =>
              onSwipe?.call(index, orientation),
          cardController: controller,
        ),
      );
}
