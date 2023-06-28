class MovieModel {
  final int id;
  final String idIMDB;
  final String title;
  final String fulltitle;
  final double? rating;
  final String image;
  final String releasedate;
  final String year;
  final String genres;
  final String plot;
  final String directors;
  final String actors;
  final String runtime;

  MovieModel({
    required this.id,
    required this.idIMDB,
    required this.title,
    required this.fulltitle,
    this.rating,
    required this.image,
    required this.releasedate,
    required this.year,
    required this.genres,
    required this.plot,
    required this.directors,
    required this.actors,
    required this.runtime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idIMDB': idIMDB,
      'title': title,
      'fulltitle': fulltitle,
      'rating': rating,
      'image': image,
      'releasedate': releasedate,
      'year': year,
      'genres': genres,
      'plot': plot,
      'directors': directors,
      'actors': actors,
      'runtime': runtime,
    };
  }

  @override
  String toString() {
    return 'MovieModel{id: $id, title: $title, fulltitle: $fulltitle, rating: $rating, image: $image, releasedate: $releasedate, year: $year, genres: $genres, plot: $plot, directors: $directors, actors: $actors, runtime: $runtime';
  }
}
