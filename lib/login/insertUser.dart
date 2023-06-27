import 'package:flutter/material.dart';
import 'package:prova_final/persistence/client_model.dart';

import '../scripts/queriessql.dart';

class AddedUser extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerVerify =
      TextEditingController();

  void _registerUser(BuildContext context) async {
    String nome = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String passwordVerify = _passwordControllerVerify.text;
    String photo = "";

    var user = UsersModel(
      id: 1,
      nome: nome,
      pwd: password,
      email: email,
      photoProfile: photo,
    );

    await DBHelper.insertUser(user);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registro concluído'),
        content: const Text('Usuário adicionado com sucesso!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Cadastro'),
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
              _buildTextFieldWithLabel('Nome de Usuário', _nameController),
              const SizedBox(height: 20),
              _buildTextFieldWithLabel('Email', _emailController),
              const SizedBox(height: 20),
              _buildTextFieldWithLabel(
                'Senha',
                _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              _buildTextFieldWithLabel(
                'Confirmar senha',
                _passwordControllerVerify,
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
                    onPressed: () => _registerUser(context),
                    child: const Text(
                      "Efetuar Cadastro",
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
