import 'dart:convert';

import 'package:dio/dio.dart';
import 'movie_class.dart';

final dio = Dio();

//pegar os top 250 filmes melhores avaliados
final Map<String, String> getTop250Headers = {
  "Accept": "application/json",
  "Content-Type": "application/json",
};

String url = "imdb-api.com";

Future<List<Filme>> catchDetails(String searchField) async {
  final response =
      await dio.get('https://imdb-api.com/pt-BR/API/Title/k_l2qk8eo4/$searchField/');

  if (response.statusCode == 200) {
    var jsonResponse = response.data;

    List<Filme> movies = [];

    Filme movie = Filme.fromJson(jsonResponse);
    movies.add(movie);

    return movies;
  } else {
    throw Exception('Failed to load selected movie');
  }
}

Future<List<Filme>> fetchTop250() async {
  final response = await dio.get(
    'https://imdb-api.com/pt-BR/API/Top250Movies/k_l2qk8eo4',
  );

  if (response.statusCode == 200) {
    var jsonResponse = (response.data);

    List<Filme> movies = [];

    for (var m in jsonResponse['items']) {
      if (m != null) {
        Filme movie = Filme.fromJson(m);
        movies.add(movie);
      }
    }
    return movies;
  } else {
    throw Exception('Failed to load Top rated movie list');
  }
}
