import 'package:shared_preferences/shared_preferences.dart';

abstract class PersistenceService {
  factory PersistenceService.build() => PersistenceServiceImpl();

  Future<String> getToken();
  Future<bool> getTesting();
  Future<void> setToken(String value);
  Future<void> setTesting(bool value);
}

class PersistenceServiceImpl implements PersistenceService {
  static const _tokenKey = 'token';
  static const _testingKey = 'testing';

  @override
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future<bool> getTesting() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_testingKey);
  }

  @override
  Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, value);
  }

  @override
  Future<void> setTesting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_testingKey, value);
  }
}
