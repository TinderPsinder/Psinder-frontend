import 'package:flutter/material.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/models/sex.dart';
import 'package:psinder/widgets/circular_button.dart';

class DogPage extends StatefulWidget {
  const DogPage({@required Dog dog, Key key})
      : assert(dog != null),
        _dog = dog,
        super(key: key);

  factory DogPage.build({@required Dog dog}) => DogPage(dog: dog);

  final Dog _dog;

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
          itemBuilder: (_, index) => Image.asset(
            widget._dog.pictures[index],
            fit: BoxFit.cover,
          ),
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
            onPressed: () {},
          ),
          CircularButton(
            color: Colors.green,
            icon: Icons.favorite,
            onPressed: () {},
          ),
        ],
      );
}
