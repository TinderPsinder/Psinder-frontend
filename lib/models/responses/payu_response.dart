import 'package:meta/meta.dart';
import 'package:psinder/utils/psinder_exception.dart';
import 'package:xml/xml.dart' as xml;

class PayuResponse {
  final String redirectUri;
  final String orderId;

  PayuResponse({@required this.redirectUri, @required this.orderId}) {
    if (redirectUri == null) throw PsinderException.parse('redirectUri');
    if (orderId == null) throw PsinderException.parse('orderId');
  }

  factory PayuResponse.fromXml(String xmlString) {
    final document = xml.parse(xmlString);
    final messageResponse = document.findElements('PayuResponse').first;

    return PayuResponse(
      redirectUri: messageResponse.findElements('redirectUri').first.text,
      orderId: messageResponse.findElements('orderId').first.text,
    );
  }
}
