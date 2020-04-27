import 'package:meta/meta.dart';

abstract class AuthService {
  factory AuthService.build() => AuthServiceImpl();

  Future<bool> isLoggedIn();

  Future<void> login({
    @required String username,
    @required String password,
  });

  Future<void> register({
    @required String username,
    @required String email,
    @required String password,
  });

  Future<void> logout();
}

class AuthServiceImpl implements AuthService {
  static bool _isLoggedIn = false;

  @override
  Future<bool> isLoggedIn() async {
    await Future.delayed(Duration(milliseconds: 1000));

    return _isLoggedIn;
  }

  @override
  Future<void> login({
    String username,
    String password,
  }) async {
    await Future.delayed(Duration(milliseconds: 1000));

    _isLoggedIn = true;
  }

  @override
  Future<void> register({
    String username,
    String email,
    String password,
  }) async {
    await Future.delayed(Duration(milliseconds: 1000));

    _isLoggedIn = true;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _isLoggedIn = false;
  }
}
