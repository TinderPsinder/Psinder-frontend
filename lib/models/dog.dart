import 'package:meta/meta.dart';
import 'package:psinder/models/sex.dart';
import 'package:psinder/utils/psinder_exception.dart';
import 'package:xml/xml.dart' as xml;

class Dog {
  final String name;
  final String breed;
  final Sex sex;
  final int age;
  final String description;
  final List<String> pictures;

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
      sex: parseSex(dog.findElements('sex').first.text),
      age: int.parse(dog.findElements('age').first.text),
      description: dog.findElements('description').first.text,
      pictures: parsePictures(dog.findElements('pictures').first),
    );
  }

  static List<String> parsePictures(xml.XmlElement pictures) =>
      pictures.findElements('picture').map((picture) => picture.text).toList();

  static Sex parseSex(String sex) {
    switch (sex.toUpperCase()) {
      case 'DOG':
        return Sex.dog;

      case 'BITCH':
        return Sex.bitch;

      default:
        return null;
    }
  }
}
