import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _tokenKey = "auth_token";

  // save token after successful login
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // get saved token (used when calling protected APIs like Get Habits)
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // remove token (used for logout)
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
