import 'package:meta/meta.dart';
import 'package:psinder/utils/psinder_exception.dart';
import 'package:xml/xml.dart' as xml;

class MessageResponse {
  final String message;

  MessageResponse({@required this.message}) {
    if (message == null) throw PsinderException.parse('message');
  }

  factory MessageResponse.fromXml(String xmlString) {
    final document = xml.parse(xmlString);
    final messageResponse = document.findElements('MessageResponse').first;

    return MessageResponse(
      message: messageResponse.findElements('message').first.text,
    );
  }
}
