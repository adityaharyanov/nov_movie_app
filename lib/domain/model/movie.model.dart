import 'package:nov_movie_app/data/constants.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final String releaseDate;
  // final List<GenreResponse> genres;
  final bool videos;
  bool isFavourite = false;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterUrl,
      required this.releaseDate,
      // required this.genres,
      required this.videos});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterUrl: json['poster_path'] ?? "",
      // voteAverage: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
      videos: json['video'],
    );
  }

  toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterUrl,
      'release_date': releaseDate,
      'video': videos,
    };
  }

  @override
  operator ==(other) => other is Movie && other.id == id;
}
