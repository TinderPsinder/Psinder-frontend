import 'package:meta/meta.dart';
import 'package:psinder/models/base/xml_encodable.dart';
import 'package:xml/xml.dart' as xml;

class LoginRequest extends XmlEncodable {
  LoginRequest({@required this.username, @required this.password})
      : assert(username != null),
        assert(password != null);

  final String username;
  final String password;

  @override
  void buildXml(xml.XmlBuilder builder) {
    builder.element('loginrequest', nest: () {
      builder.element('username', nest: username);
      builder.element('password', nest: password);
    });
  }
}
