import 'package:meta/meta.dart';
import 'package:psinder/services/auth_service.dart';
import 'package:psinder/utils/psinder_exception.dart';

class AuthServiceMock implements AuthService {
  static bool _isLoggedIn = false;

  static final _registeredUsers = [
    _User(email: 'test@test.pl', username: 'test', password: '123456'),
  ];

  @override
  Future<bool> isLoggedIn() async {
    return _isLoggedIn;
  }

  @override
  Future<void> login({
    String username,
    String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));

    if (_registeredUsers
        .where((user) => user.username == username && user.password == password)
        .isNotEmpty) {
      _isLoggedIn = true;
    } else {
      throw PsinderException('exception.auth.unauthorized');
    }
  }

  @override
  Future<String> register({
    String username,
    String email,
    String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));

    _registeredUsers.add(_User(
      username: username,
      email: email,
      password: password,
    ));

    return 'Rejestracja przebiegła pomyślnie!';
  }

  @override
  Future<void> logout() async {
    _isLoggedIn = false;
  }
}

class _User {
  final String username;
  final String email;
  final String password;

  _User({
    @required this.username,
    @required this.email,
    @required this.password,
  })  : assert(username != null),
        assert(email != null),
        assert(password != null);
}
