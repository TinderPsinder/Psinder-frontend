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

  Dog copy() => Dog(
        name: name,
        breed: breed,
        sex: sex,
        age: age,
        description: description,
        pictures: List.from(pictures),
      );

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
          name: 'Burek',
          breed: 'York',
          sex: Sex.dog,
          age: 3,
          description: 'Lubię sport',
          pictures: [
            'https://i.imgur.com/2Yq8PMw.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Azor',
          breed: 'Kundel',
          sex: Sex.dog,
          age: 8,
          description: 'Jestem kundlem, który lubi dobrą zabawę.',
          pictures: [
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Bruno',
          breed: 'Golden  Retriever',
          sex: Sex.dog,
          age: 5,
          description:
              'Lubię się dobrze zabawić oraz towarzystwo pięknych suczek.',
          pictures: [
            'https://i.imgur.com/jGhU3aI.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Antek',
          description: 'Szukam stałej relacji',
          breed: 'Kundel',
          sex: Sex.dog,
          age: 2,
          pictures: [
            'https://i.imgur.com/Ds47rBs.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Ania',
          breed: 'Maltańczyk',
          sex: Sex.bitch,
          age: 3,
          description: 'Nie wiem czego tu szukam',
          pictures: [
            'https://i.imgur.com/ZaCGlO1.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Paweł',
          breed: 'Maltańczyk',
          sex: Sex.dog,
          age: 5,
          description: 'Kocham podróże',
          pictures: [
            'https://i.imgur.com/ljQsdUk.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Saba',
          breed: 'York',
          sex: Sex.bitch,
          age: 5,
          description: 'Gryzę',
          pictures: [
            'https://i.imgur.com/2Yq8PMw.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Azorek',
          breed: 'Kundel',
          sex: Sex.dog,
          age: 3,
          description: 'Jestem zabawnym psem',
          pictures: [
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Grot',
          breed: 'Owczarek',
          sex: Sex.dog,
          age: 7,
          description: 'Zapraszam na priv',
          pictures: [
            'https://i.imgur.com/jGhU3aI.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Frania',
          breed: 'Mops',
          sex: Sex.bitch,
          age: 3,
          description: 'Klasa i styl',
          pictures: [
            'https://i.imgur.com/Ds47rBs.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Alexandra',
          breed: 'Mops',
          sex: Sex.bitch,
          age: 4,
          description: 'Lubię długie rozmowy wieczorami. Popiszemy?',
          pictures: [
            'https://i.imgur.com/ZaCGlO1.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Kristina',
          breed: 'Pudel',
          sex: Sex.bitch,
          age: 8,
          description: 'Lubię imprezy techno',
          pictures: [
            'https://i.imgur.com/ljQsdUk.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Alex',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 4,
          description:
              'Jestem człowiekiem pracy, ale chętnie wyjdę wieczorem na wino',
          pictures: [
            'https://i.imgur.com/2Yq8PMw.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Marcin',
          breed: 'Jamnik',
          sex: Sex.dog,
          age: 3,
          description:
              'Zajmuję się ogrodnictwem, posiadam sad, gdzie hoduję wiśnie. Dodatkowo jestem właścicielem lasu z przytulnym leśnym zagajniczkiem. Chętnie Cię tam zabiorę i spędzimy miło czas',
          pictures: [
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
        Dog(
          name: 'Alojzy',
          breed: 'Beagle',
          sex: Sex.dog,
          age: 7,
          description: 'Popiszemy? :))))',
          pictures: [
            'https://i.imgur.com/jGhU3aI.jpg',
            'https://i.imgur.com/VH03jm9.jpg',
          ],
        ),
      ];
}
