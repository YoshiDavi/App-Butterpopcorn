import 'package:flutter/material.dart';
import 'package:prova_final/model/APIrequests.dart';
import 'package:prova_final/persistence/movie_model.dart';
import 'package:prova_final/scripts/queriessql.dart';
import 'package:intl/intl.dart';

import 'movie_class.dart';

class MovieDetails extends StatefulWidget {
  final Filme movie;

  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

void _seenMovieADD(BuildContext context, MovieModel sm) async {
  await DBHelper.insertSeenMovie(sm);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Marcado como assistido!'),
      content: const Text('O filme foi adicionado aos assistidos/meus filmes'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

void _seenMovieDEL(BuildContext context, String id) async {
  await DBHelper.deleteSmovie(id);
}

void _favMovieADD(BuildContext context, MovieModel fm) async {
  await DBHelper.insertFavMovie(fm);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Favoritado com sucesso!'),
      content: const Text('O filme foi adicionado aos favoritos'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

void _favMovieDEL(BuildContext context, String id) async {
  await DBHelper.deleteFmovie(id);
}

class _MovieDetailsState extends State<MovieDetails> {
  bool isStarred = false;
  bool isChecked = false;
  final currentTimestamp = DateFormat('yyyyMMddHHmmss').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Future<List<Filme>> mvsReturn = catchDetails(widget.movie.id);
    return FutureBuilder<List<Filme>>(
        future: mvsReturn,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                toolbarHeight: 90,
                automaticallyImplyLeading: false,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.yellow, width: 2)),
                  ),
                ),
                title: Center(
                  child: Column(
                    children: [
                      Text(widget.movie.title),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${snapshot.data!.first.runtime} • ${snapshot.data!.first.genres}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            children: [
                              Container(
                                width: 150,
                                child: Image.network(
                                  snapshot.data!.first.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Original: ${snapshot.data!.first.fulltitle}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Lançamento: ${snapshot.data!.first.releasedate}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Diretor: ${snapshot.data!.first.directors}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 50),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            isStarred
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.yellow,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            var fmovie = MovieModel(
                                              id: int.parse(currentTimestamp),
                                              idIMDB: widget.movie.id,
                                              title: snapshot.data!.first.title,
                                              fulltitle: snapshot
                                                  .data!.first.fulltitle,
                                              image: snapshot.data!.first.image,
                                              releasedate: snapshot
                                                  .data!.first.releasedate,
                                              year: snapshot.data!.first.year,
                                              genres:
                                                  snapshot.data!.first.genres,
                                              plot: snapshot.data!.first.plot,
                                              directors: snapshot
                                                  .data!.first.directors,
                                              actors:
                                                  snapshot.data!.first.actors,
                                              runtime:
                                                  snapshot.data!.first.runtime,
                                            );

                                            Future<List<Map<String, dynamic>>>
                                                map = DBHelper.getFavs();

                                            map.then((list) {
                                              String campo = 'idIMDB';
                                              String valor =
                                                  snapshot.data!.first.id;

                                              bool recordExists = false;

                                              for (var m in list) {
                                                if (m.containsKey(campo) &&
                                                    m[campo] == valor) {
                                                  recordExists = true;
                                                  break;
                                                }
                                              }

                                              if (recordExists) {
                                                setState(() {
                                                  _favMovieDEL(
                                                      context, fmovie.idIMDB);
                                                  isStarred = false;
                                                });
                                              } else {
                                                setState(() {
                                                  _favMovieADD(context, fmovie);
                                                  isStarred = true;
                                                });
                                              }
                                            }).catchError((error) {
                                              print(
                                                  "Error requesting the map: $error");
                                            });
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          icon: Icon(
                                            isChecked
                                                ? Icons.check_box
                                                : Icons.check_box_outline_blank,
                                            color: Colors.yellow,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (!isChecked) {
                                                var smovie = MovieModel(
                                                  id: int.parse(
                                                      currentTimestamp),
                                                  idIMDB:
                                                      snapshot.data!.first.id,
                                                  title: snapshot
                                                      .data!.first.title,
                                                  fulltitle: snapshot
                                                      .data!.first.fulltitle,
                                                  image: snapshot
                                                      .data!.first.image,
                                                  releasedate: snapshot
                                                      .data!.first.releasedate,
                                                  year:
                                                      snapshot.data!.first.year,
                                                  genres: snapshot
                                                      .data!.first.genres,
                                                  plot:
                                                      snapshot.data!.first.plot,
                                                  directors: snapshot
                                                      .data!.first.directors,
                                                  actors: snapshot
                                                      .data!.first.actors,
                                                  runtime: snapshot
                                                      .data!.first.runtime,
                                                );

                                                _seenMovieADD(context, smovie);

                                                isChecked = !isChecked;
                                              } else {
                                                _seenMovieDEL(context,
                                                    snapshot.data!.first.id);
                                                isChecked = !isChecked;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          // Linha amarela
                          color: Colors.yellow,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Elenco",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data!.first.actors,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          // Linha amarela
                          color: Colors.yellow,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  "Sinopse",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data!.first.plot,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          }
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
