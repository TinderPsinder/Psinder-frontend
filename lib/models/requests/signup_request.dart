import 'package:meta/meta.dart';
import 'package:psinder/models/base/xml_encodable.dart';
import 'package:psinder/models/role.dart';
import 'package:xml/xml.dart' as xml;

class SignupRequest extends XmlEncodable {
  SignupRequest({
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.roles,
  })  : assert(username != null),
        assert(email != null),
        assert(password != null),
        assert(roles != null);

  final String username;
  final String email;
  final String password;
  final Set<Role> roles;

  @override
  void buildXml(xml.XmlBuilder builder) {
    builder.element('signuprequest', nest: () {
      builder.element('username', nest: username);
      builder.element('email', nest: email);
      builder.element('password', nest: password);
      builder.element('roles', nest: () {
        roles.forEach((role) {
          switch (role) {
            case Role.admin:
              builder.element('string', nest: 'admin');
              break;

            case Role.moderator:
              builder.element('string', nest: 'mod');
              break;

            case Role.user:
              builder.element('string', nest: 'user');
              break;
          }
        });
      });
    });
  }
}
