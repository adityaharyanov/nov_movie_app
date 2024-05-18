import 'package:nov_movie_app/data/constants.dart';
import 'package:nov_movie_app/data/data_provider/movie_api.provider.dart';
import 'package:nov_movie_app/data/data_provider/movie_local.provider.dart';
import 'package:nov_movie_app/domain/model/movie.model.dart';
import 'package:nov_movie_app/domain/model/movie_list.model.dart';

class MovieRepository {
  final MovieLocalProvider _movieLocalProvider;
  final MovieApiProvider _movieApiProvider;

  MovieRepository(
      {required MovieLocalProvider movieLocalProvider,
      required MovieApiProvider movieApiProvider})
      : _movieApiProvider = movieApiProvider,
        _movieLocalProvider = movieLocalProvider;

  Future<MovieList> fetchAllMovies({int page = 1}) async {
    var raw = await _movieApiProvider.fetchAllMovies(page);
    var result = MovieList.fromJson(raw);

    result.results = await _checkFavourite(result.results);

    _movieLocalProvider.saveAsCache(result);
    return result;
  }

  Future<List<Movie>> fetchFavouriteMovies() async {
    var result = await _movieLocalProvider.fetchFavouriteMovie();
    return result.toList();
  }

  Future<List<Movie>> searchMovies(String query) async {
    var raw = await _movieApiProvider.searchMovies(query);
    var result = MovieList.fromJson(raw);

    result.results = await _checkFavourite(result.results);

    return result.results;
  }

  Future<List<Movie>> _checkFavourite(List<Movie> movies) async {
    var local = await fetchFavouriteMovies();
    var localIds = local.map((e) => e.id).toList();
    for (var element in movies) {
      element.isFavourite = localIds.contains(element.id);
    }

    return movies;
  }

  Future toggleFavourite(Movie movie) {
    return _movieLocalProvider.toggleFavourite(movie);
  }
}

abstract class MovieDataProvider {
  Future<MovieList> fetchAllMovies(int page);
  Future<List<Movie>> searchMovies(String query);
  save(Movie movie);
}
