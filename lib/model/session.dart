import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String isLoggedInKey = 'isLoggedIn';

  // Verifica se o usuário está logado
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  // Realiza o login do usuário
  static Future<void> login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, true);
  }

  // Realiza o logout do usuário
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, false);
  }
}
