import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../persistence/clientUpdate_model.dart';
import '../scripts/queriessql.dart';

class EditProfile extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String? user;

  EditProfile({super.key, this.user});

  void _updateUser(BuildContext context) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    Database db = await DBHelper.database();

    if (user != null) {
      List<Map<String, dynamic>> result = await db.query(
        'Users',
        where: 'nome = ?',
        whereArgs: [user],
      );

      if (result.isNotEmpty && result[0]['password'] == password) {
        String oldName = result[0]['nome'];
        String oldEmail = result[0]['email'];
        String pwd = result[0]['password'];
        int id = result[0]['id'];

        var userUpdated = UserUpdateModel(
          nome: name.isNotEmpty ? name : oldName,
          email: email.isNotEmpty ? email : oldEmail,
          pwd: pwd,
        );
        await DBHelper.updateUserId(userUpdated, id);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lembrete!'),
            content: const Text('Usuário Atualizado com sucesso!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Atenção!'),
            content: const Text('As senhas não correspondem'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 215, 0, 1),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              _buildTextFieldWithLabel(
                'Nome de Usuário',
                _nameController,
              ),
              const SizedBox(height: 20),
              _buildTextFieldWithLabel(
                'E-mail',
                _emailController,
              ),
              const SizedBox(height: 20),
              _buildTextFieldWithLabel(
                'Senha (atual)',
                _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.75, 50),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromRGBO(255, 215, 0, 1)),
                            borderRadius: BorderRadius.circular(16.0))),
                    onPressed: () => _updateUser(context),
                    child: const Text(
                      "Alterar dados",
                      style: TextStyle(color: Color.fromRGBO(255, 215, 0, 1)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextFieldWithLabel(String label, TextEditingController controller,
    {bool obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(255, 215, 0, 1),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 215, 0, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(255, 215, 0, 1)),
          ),
        ),
      ),
    ],
  );
}
