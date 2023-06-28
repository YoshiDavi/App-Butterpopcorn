import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String isLogged = 'isLogged';

  static Future<void> login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogged, true);
  }

  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogged, false);
  }
}
