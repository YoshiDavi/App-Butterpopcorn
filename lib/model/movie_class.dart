class Filme {
  String id;
  String title;
  String fulltitle;
  double rating;
  String image;
  String releasedate;
  String year;
  String genres;
  String plot;
  String directors;
  String actors;
  String runtime;

  Filme({
    required this.id,
    required this.title,
    required this.fulltitle,
    required this.rating,
    required this.image,
    required this.releasedate,
    required this.year,
    required this.genres,
    required this.plot,
    required this.directors,
    required this.actors,
    required this.runtime,
  });

  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      fulltitle: json['fullTitle'] ?? '',
      rating:
          json['imDbRating'] != null ? double.parse(json['imDbRating']) : 0.0,
      image: json['image'].toString(),
      releasedate: json['releaseDate'] ?? '',
      year: json['year'] ?? '',
      genres: json['genres'] ?? '',
      plot: json['plot'] ?? '',
      directors: json['directors'] ?? '',
      actors: json['stars'] ?? '',
      runtime: json['runtimeStr'] ?? '',
    );
  }
}
