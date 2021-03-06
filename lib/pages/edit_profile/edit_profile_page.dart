import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psinder/extensions/future_loader.dart';
import 'package:psinder/models/dog.dart';
import 'package:psinder/models/sex.dart';
import 'package:psinder/pages/dog/dog_page.dart';
import 'package:psinder/pages/photo/photo_page.dart';
import 'package:psinder/services/firebase_service.dart';
import 'package:psinder/utils/build_image.dart';
import 'package:psinder/widgets/circular_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    @required Dog dog,
    @required FirebaseService firebaseService,
    Key key,
  })  : assert(dog != null),
        assert(firebaseService != null),
        _dog = dog,
        _firebaseService = firebaseService,
        super(key: key);

  factory EditProfilePage.build({@required Dog dog}) => EditProfilePage(
        dog: dog,
        firebaseService: FirebaseService.build(),
      );

  final Dog _dog;
  final FirebaseService _firebaseService;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  Dog _dog;

  @override
  void initState() {
    super.initState();

    _dog = widget._dog.copy();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(tr('edit_profile.title')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: _onPreviewPressed,
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _onAcceptPressed,
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 32.0),
                height: 96.0,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for (int i = 0; i < _dog.pictures.length; i++)
                      _buildPhotoTile(_dog.pictures[i], i),
                    _buildUploadTile(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildFormContent(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTile(Widget child) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: child,
          ),
        ),
      );

  Widget _buildPhotoTile(String photo, int i) => _buildTile(
        GestureDetector(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.network(
                  photo,
                  fit: BoxFit.cover,
                  loadingBuilder: buildImageLoader,
                  errorBuilder: buildImageError,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: CircularButton(
                  color: Colors.red,
                  icon: Icons.close,
                  compact: true,
                  onPressed: () => setState(() => _dog.pictures.removeAt(i)),
                ),
              ),
            ],
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
          onLongPress: () => setState(() {
            _dog.pictures.removeAt(i);
            _dog.pictures.insert(0, photo);
          }),
        ),
      );

  Widget _buildUploadTile() => _buildTile(
        Material(
          color: Colors.grey.shade200,
          child: InkWell(
            onTap: _onUploadTilePressed,
            child: Icon(
              Icons.add_a_photo,
              size: 32.0,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      );

  List<Widget> _buildFormContent() => <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: tr('edit_profile.name'),
                ),
                initialValue: _dog.name,
                onChanged: (value) => _dog.name = value.trim(),
                validator: _validateField,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: tr('edit_profile.age')),
                initialValue: _dog.age.toString(),
                onChanged: (value) => _dog.age = int.parse(value.trim()),
                validator: _validateField,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _buildSexDropdown()),
            SizedBox(width: 16.0),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: tr('edit_profile.breed'),
                ),
                initialValue: _dog.breed,
                onChanged: (value) => _dog.breed = value.trim(),
                validator: _validateField,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        TextFormField(
          decoration: InputDecoration(
            labelText: tr('edit_profile.description'),
          ),
          initialValue: _dog.description,
          onChanged: (value) => _dog.description = value.trim(),
          validator: _validateField,
          maxLines: 4,
        ),
      ];

  Widget _buildSexDropdown() => Container(
        height: 34,
        margin: EdgeInsets.only(top: 25.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          isDense: true,
          onChanged: (value) => setState(() => _dog.sex = Sex.values[value]),
          value: _dog.sex.index,
          underline: SizedBox.shrink(),
          items: Sex.values
              .map(
                (Sex value) => DropdownMenuItem(
                  value: value.index,
                  child: Text(value.toLocalizedString()),
                ),
              )
              .toList(),
        ),
      );

  String _validateField(String value) =>
      value.trim().isEmpty ? tr('edit_profile.error') : null;

  void _onPreviewPressed() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DogPage.build(dog: _dog),
      ),
    );
  }

  void _onAcceptPressed() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    Navigator.pop(context, _dog);
  }

  Future<void> _onUploadTilePressed() async {
    final image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 80,
    );

    final filename = image?.path?.split('/')?.last;
    if (filename == null) return;

    final name = filename.replaceFirst('image_picker_', '');
    final contentType = _extToContentType(filename.split('.').last);

    final uploadedUrl = await Navigator.of(context).futureLoader(
      widget._firebaseService.uploadToStorage(
        contentType: contentType,
        content: await image.readAsBytes(),
        path: 'app/$name',
      ),
    );

    setState(() => _dog.pictures.add(uploadedUrl));
  }

  String _extToContentType(String ext) {
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'jpeg':
      case 'jpg':
        return 'image/jpeg';
      default:
        return null;
    }
  }
}
