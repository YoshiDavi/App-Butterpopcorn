import 'package:flutter/material.dart';
import 'package:prova_final/model/movieDetails.dart';
import '../model/APIrequests.dart';
import '../model/movie_class.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Filme>> mvsReturn = fetchTop250();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Filme>>(
        future: mvsReturn,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 35,
                childAspectRatio: 0.7,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: InkWell(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetails(
                                movie: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                            ),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              snapshot.data![index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          }
          return const Text("Loading...");
        },
      ),
    );
  }
}
