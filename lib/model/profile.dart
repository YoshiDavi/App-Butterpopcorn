import 'package:flutter/material.dart';
import 'package:prova_final/model/session.dart';
import 'package:sqflite/sqflite.dart';

import '../login/login.dart';
import '../scripts/queriessql.dart';
import 'editProfile.dart';

class Profile extends StatefulWidget {
  final String? user;
  Profile({Key? key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String nome = "";

  @override
  void initState() {
    super.initState();
    _login();
  }

  void _login() async {
    Database db = await DBHelper.database();

    List<Map<String, dynamic>> result = await db.query(
      'Users',
      where: 'nome = ?',
      whereArgs: [widget.user],
    );
    setState(() {
      nome = result.isNotEmpty ? result[0]['nome'] : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 99, 99, 99),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: _height / 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage('assets/images/test.jpg'),
                      radius: _height / 12,
                    ),
                    SizedBox(
                      height: _height / 200,
                    ),
                    Text(
                      nome,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfile(user: widget.user!),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.edit),
                                SizedBox(width: 4),
                                Text('Editar Perfil'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                              await SessionManager.logout();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.logout),
                                SizedBox(width: 4),
                                Text('Logout'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _height / 2.6),
              child: Container(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
