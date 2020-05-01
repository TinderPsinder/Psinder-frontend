import 'package:meta/meta.dart';
import 'package:psinder/models/role.dart';
import 'package:xml/xml.dart' as xml;

class JwtResponse {
  final String id;
  final String username;
  final String email;
  final Set<Role> roles;
  final String accessToken;
  final String tokenType;

  JwtResponse({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.roles,
    @required this.accessToken,
    @required this.tokenType,
  })  : assert(id != null),
        assert(username != null),
        assert(email != null),
        assert(roles != null),
        assert(accessToken != null),
        assert(tokenType != null);

  factory JwtResponse.fromXml(String xmlString) {
    final document = xml.parse(xmlString);
    final jwtResponse = document.findElements('JwtResponse').first;

    return JwtResponse(
      id: jwtResponse.findElements('id').first.text,
      username: jwtResponse.findElements('username').first.text,
      email: jwtResponse.findElements('email').first.text,
      roles: parseRoles(jwtResponse.findElements('roles').first),
      accessToken: jwtResponse.findElements('accessToken').first.text,
      tokenType: jwtResponse.findElements('tokenType').first.text,
    );
  }

  static Set<Role> parseRoles(xml.XmlElement roles) => roles
      .findElements('roles')
      .map((role) {
        switch (role.text) {
          case 'ROLE_USER':
            return Role.user;

          case 'ROLE_MODERATOR':
            return Role.moderator;

          case 'ROLE_ADMIN':
            return Role.admin;

          default:
            return null;
        }
      })
      .where((role) => role != null)
      .toSet();
}
