import 'package:meta/meta.dart';
import 'package:psinder/models/sex.dart';
import 'package:psinder/utils/psinder_exception.dart';
import 'package:xml/xml.dart' as xml;

class Dog {
  String name;
  String breed;
  Sex sex;
  int age;
  String description;
  List<String> pictures;

  Dog({
    @required this.name,
    @required this.breed,
    @required this.sex,
    @required this.age,
    @required this.description,
    @required this.pictures,
  }) {
    if (name == null) throw PsinderException.parse('name');
    if (breed == null) throw PsinderException.parse('breed');
    if (sex == null) throw PsinderException.parse('sex');
    if (age == null) throw PsinderException.parse('age');
    if (description == null) throw PsinderException.parse('description');
    if (pictures == null) throw PsinderException.parse('pictures');
  }

  factory Dog.fromXml(String xmlString) {
    final document = xml.parse(xmlString);
    final dog = document.findElements('Dog').first;

    return Dog(
      name: dog.findElements('name').first.text,
      breed: dog.findElements('breed').first.text,
      sex: _parseSex(dog.findElements('sex').first.text),
      age: int.parse(dog.findElements('age').first.text),
      description: dog.findElements('description').first.text,
      pictures: _parsePictures(dog.findElements('pictures').first),
    );
  }

  static List<String> _parsePictures(xml.XmlElement pictures) =>
      pictures.findElements('picture').map((picture) => picture.text).toList();

  static Sex _parseSex(String sex) {
    switch (sex.toUpperCase()) {
      case 'DOG':
        return Sex.dog;

      case 'BITCH':
        return Sex.bitch;

      default:
        return null;
    }
  }

  static List<Dog> get mocks => [
        Dog(
          name: 'Pies',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 10,
          description:
              'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
          pictures: [
            'https://i.imgur.com/2Yq8PMw.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Pies',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 10,
          description:
              'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
          pictures: [
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Pies',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 10,
          description:
              'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
          pictures: [
            'https://i.imgur.com/jGhU3aI.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Pies',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 10,
          description:
              'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
          pictures: [
            'https://i.imgur.com/Ds47rBs.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Pies',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 10,
          description:
              'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
          pictures: [
            'https://i.imgur.com/ZaCGlO1.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Pies',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 10,
          description:
              'Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies. Pies pies pies pies pies pies pies pies pies pies.',
          pictures: [
            'https://i.imgur.com/ljQsdUk.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
      ];
}
