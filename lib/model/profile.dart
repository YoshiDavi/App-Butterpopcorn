import 'package:flutter/material.dart';
import 'package:prova_final/model/session.dart';
import 'package:sqflite/sqflite.dart';
import '../login/login.dart';
import '../scripts/queriessql.dart';
import 'editProfile.dart';
import 'movie_class.dart';

class Profile extends StatefulWidget {
  final String? user;
  const Profile({Key? key, this.user}) : super(key: key);

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
    final _height = MediaQuery.of(context).size.height;

    var sm = Filme(
        actors: '',
        directors: '',
        fulltitle: '',
        genres: '',
        id: '',
        image: '',
        plot: '',
        rating: 0.0,
        releasedate: '',
        runtime: '',
        title: '',
        year: '');
    ;
    var fm = Filme(
        actors: '',
        directors: '',
        fulltitle: '',
        genres: '',
        id: '',
        image: '',
        plot: '',
        rating: 0.0,
        releasedate: '',
        runtime: '',
        title: '',
        year: '');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
              border: Border(
                bottom: BorderSide(color: Colors.yellow, width: 5)),
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
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 4),
                                    Text('Editar Perfil'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
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
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                child: const Row(
                                  children: [
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
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        "Filmes Favoritos",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 2,),
                      Icon(Icons.star, color: Colors.yellow,),
                    ],
                  ),
                ),
                const SizedBox(width: 2,),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  height: 120,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: DBHelper.getFavs(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (context, index) {
                            final favsMap = snapshot.data![index];
                            final uniqueKey = ValueKey(favsMap['id']);

                            fm.id = favsMap['id'].toString();
                            fm.title = favsMap['title'];
                            fm.fulltitle = favsMap['fulltitle'];
                            fm.rating = 1;
                            fm.image = favsMap['image'];
                            fm.releasedate = favsMap['releasedate'];
                            fm.year = favsMap['year'];
                            fm.genres = favsMap['genres'];
                            fm.plot = favsMap['plot'];
                            fm.genres = favsMap['genres'];
                            fm.directors = favsMap['directors'];
                            fm.actors = favsMap['actors'];
                            fm.runtime = favsMap['runtime'];

                             return Padding(
                              key: uniqueKey,
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.0,
                                    ),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      favsMap['image'],
                                    fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                             ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.yellow,
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        "Filmes Assistidos",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 2,),
                      Icon(Icons.check_box, color: Colors.yellow,),
                    ],
                  ),
                ),
                const SizedBox(width: 2,),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    height: 120,
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: DBHelper.getSeen(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            ),
                            itemBuilder: (context, index) {
                              final seenMap = snapshot.data![index];
                              final uniqueKey = ValueKey(seenMap['id']);

                              sm.id = seenMap['id'].toString();
                              sm.title = seenMap['title'];
                              sm.fulltitle = seenMap['fulltitle'];
                              sm.rating = 1;
                              sm.image = seenMap['image'];
                              sm.releasedate = seenMap['releasedate'];
                              sm.year = seenMap['year'];
                              sm.genres = seenMap['genres'];
                              sm.plot = seenMap['plot'];
                              sm.directors = seenMap['directors'];
                              sm.actors = seenMap['actors'];
                              sm.runtime = seenMap['runtime'];

                              return Padding(
                                key: uniqueKey,
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1.0,
                                      ),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.network(
                                        seenMap['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
