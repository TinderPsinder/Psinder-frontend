import 'package:xml/xml.dart' as xml;

abstract class XmlEncodable {
  void buildXml(xml.XmlBuilder builder);

  String toXml({bool withProcessing = true}) {
    final builder = xml.XmlBuilder();

    if (withProcessing) {
      builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    }

    buildXml(builder);

    return builder.build().toXmlString(pretty: true, indent: '    ');
  }
}
