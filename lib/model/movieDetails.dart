import 'package:flutter/material.dart';
import 'package:prova_final/model/APIrequests.dart';

import 'movie_class.dart';

class MovieDetails extends StatefulWidget {
  final Filme movie;

  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool isStarred = false;
  bool isChecked = false;

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
                    border: Border(bottom: BorderSide(color: Colors.yellow, width: 2)), // Borda amarela apenas na parte inferior
                  ),
                ),
                title: Center(
                  child: Column(
                    children: [
                      Text(widget.movie.title),
                      SizedBox(height: 8,),
                      Text(snapshot.data!.first.runtime + " • " + snapshot.data!.first.genres, style: TextStyle(fontSize: 16, color: Colors.white),),
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
                                SizedBox(width: 16,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Original: " + snapshot.data!.first.fulltitle,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Lançamento: " + snapshot.data!.first.releasedate,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Diretor: " + snapshot.data!.first.directors,
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(height: 50),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              isStarred ? Icons.star : Icons.star_border,
                                              color: Colors.yellow,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isStarred = !isStarred;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 8),
                                          IconButton(
                                            icon: Icon(
                                              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                                              color: Colors.yellow,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                isChecked = !isChecked;
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
                          Divider( // Linha amarela
                            color: Colors.yellow,
                            thickness: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Elenco",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  snapshot.data!.first.actors,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Divider( // Linha amarela
                            color: Colors.yellow,
                            thickness: 2,
                          ),
                          Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sinopse",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                snapshot.data!.first.plot,
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        ],
                      )
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
    );
  }
}