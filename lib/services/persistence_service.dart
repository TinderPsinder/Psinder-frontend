import 'package:shared_preferences/shared_preferences.dart';

abstract class PersistenceService {
  factory PersistenceService.build() => PersistenceServiceImpl();

  Future<String> getToken();
  Future<void> setToken(String value);
}

class PersistenceServiceImpl implements PersistenceService {
  static const _tokenKey = 'token';

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, value);
  }
}
