import 'package:nov_movie_app/domain/model/movie.model.dart';

class MovieList {
  final int page;
  final int totalResults;
  final int totalPages;
  List<Movie> results;

  MovieList(
      {required this.page,
      required this.totalResults,
      required this.totalPages,
      required this.results});

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: (json['results'] as List).map((e) => Movie.fromJson(e)).toList(),
    );
  }

  toJson() {
    return {
      'page': page,
      'total_results': totalResults,
      'total_pages': totalPages,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}
