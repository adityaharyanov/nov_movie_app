import 'package:nov_movie_app/data/model/movie_response.model.dart';

class MovieListResponse {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<MovieResponse> results;

  MovieListResponse(
      {required this.page,
      required this.totalResults,
      required this.totalPages,
      required this.results});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
      results: json['results'],
    );
  }
}
