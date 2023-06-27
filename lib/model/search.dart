import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prova_final/model/movieDetails.dart';

import 'APIrequests.dart';
import 'movie_class.dart';

class Search extends StatefulWidget { 
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  Future<List<Filme>> mvsReturn = fetchTop250();

  void searching() {
    setState(() {
      if (_searchController.text.isNotEmpty) {
        mvsReturn = searchMovie(_searchController.text);
      } else {
        mvsReturn = fetchTop250();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Pesquise aqui!',
                      labelStyle: const TextStyle(color: Colors.black, height: 5),
                      filled: true,
                      fillColor: const Color.fromRGBO(255, 215, 0, 1),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.yellow),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.yellow, width: 15.0),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.05, 60),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Colors.yellow, width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: searching, // Chama o método searching ao ser clicado
                  child: const Text('Pesquisar'),
                ),
              ],
            ),
            FutureBuilder<List<Filme>>(
              future: mvsReturn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text("Error");
                }
                return const Text("Loading...");
              },
            ),
          ],
        ),
      ),
    );
  }
}
