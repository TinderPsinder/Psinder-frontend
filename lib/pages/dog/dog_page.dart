import 'package:flutter/material.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/models/sex.dart';
import 'package:psinder/pages/photo/photo_page.dart';
import 'package:psinder/services/cards_service.dart';
import 'package:psinder/utils/build_image.dart';
import 'package:psinder/widgets/circular_button.dart';

class DogPage extends StatefulWidget {
  const DogPage({
    @required Dog dog,
    @required CardsService cardsService,
    Key key,
  })  : assert(dog != null),
        assert(cardsService != null),
        _dog = dog,
        _cardsService = cardsService,
        super(key: key);

  factory DogPage.build({@required Dog dog}) => DogPage(
        dog: dog,
        cardsService: CardsService.build(),
      );

  final Dog _dog;
  final CardsService _cardsService;

  @override
  _DogPageState createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildPhotos(),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: _buildNameAge(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                bottom: 16.0,
              ),
              child: _buildSexBreed(),
            ),
            _buildSeparator(),
            Expanded(child: _buildDescription()),
            _buildSeparator(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: _buildButtonsRow(),
            ),
          ],
        ),
      );

  Widget _buildPhotos() => AspectRatio(
        aspectRatio: 1.2,
        child: PageView.builder(
          itemCount: widget._dog.pictures.length,
          itemBuilder: (_, index) {
            final photo = widget._dog.pictures[index];

            return GestureDetector(
              child: Image.network(
                photo,
                fit: BoxFit.cover,
                loadingBuilder: buildImageLoader,
                errorBuilder: buildImageError,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhotoPage.build(
                    image: NetworkImage(photo),
                  ),
                  fullscreenDialog: true,
                ),
              ),
            );
          },
        ),
      );

  Widget _buildNameAge() => Row(
        children: <Widget>[
          Text(
            widget._dog.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            ', ${widget._dog.age}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );

  Widget _buildSexBreed() => Row(
        children: <Widget>[
          Text(
            widget._dog.sex.toLocalizedString(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            ', ${widget._dog.breed}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );

  Widget _buildSeparator() => Container(
        height: 1.0,
        color: Colors.grey.shade300,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
      );

  Widget _buildDescription() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget._dog.description,
            textAlign: TextAlign.left,
          ),
        ),
      );

  Widget _buildButtonsRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircularButton(
            color: Colors.red,
            icon: Icons.close,
            onPressed: () => widget._cardsService.dislike(widget._dog),
          ),
          CircularButton(
            color: Colors.green,
            icon: Icons.favorite,
            onPressed: () => widget._cardsService.like(widget._dog),
          ),
        ],
      );
}
