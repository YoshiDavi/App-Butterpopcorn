import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import '../model/home_page.dart';
import '../model/session.dart';
import '../scripts/queriessql.dart';
import 'changePassword.dart';
import 'insertUser.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _login(BuildContext context) async {
    String user = _userController.text;
    String password = _passwordController.text;
    Database db = await DBHelper.database();

    List<Map<String, dynamic>> result = await db.query(
      'Users',
      where: 'nome = ? AND password = ?',
      whereArgs: [user, password],
    );

    if (result.isNotEmpty) {
      await SessionManager.login();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeButterPopCorn(user: user)),
      );
      _userController.clear();
      _passwordController.clear();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erro de login'),
          content:
              const Text('Credenciais inválidas. Por favor, tente novamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      _userController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/icon.png'),
              width: 200,
              height: 250,
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: _userController,
              decoration: InputDecoration(
                labelText: 'Usuário',
                labelStyle: const TextStyle(color: Colors.black, height: 5),
                filled: true,
                fillColor: const Color.fromRGBO(255, 215, 0, 1),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.yellow),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide:
                        const BorderSide(color: Colors.yellow, width: 15.0)),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: const TextStyle(color: Colors.black, height: 5),
                filled: true,
                fillColor: const Color.fromRGBO(255, 215, 0, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              width: 130,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.75, 50),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.yellow, width: 2.0),
                          borderRadius: BorderRadius.circular(16.0))),
                  onPressed: () => _login(context),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddedUser()));
              },
              child: const Text(
                'Não possui conta? Cadastre-se',
                style: TextStyle(
                  color: Colors.yellow,
                  height: 3,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePassword()));
              },
              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(
                  color: Colors.yellow,
                  decoration: TextDecoration.underline,
                  height: 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
