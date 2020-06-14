import 'package:meta/meta.dart';
import 'package:psinder/utils/psinder_exception.dart';
import 'package:xml/xml.dart' as xml;

class Likes {
  List<int> liked;
  List<int> disliked;

  Likes({
    @required this.liked,
    @required this.disliked,
  }) {
    if (liked == null) throw PsinderException.parse('liked');
    if (disliked == null) throw PsinderException.parse('disliked');
  }

  factory Likes.fromXml(String xmlString) {
    final document = xml.parse(xmlString);
    final likes = document.findElements('Likes').first;

    throw PsinderException.unknown();
  }
}
