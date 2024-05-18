import 'dart:convert';

import 'package:nov_movie_app/domain/model/movie.model.dart';
import 'package:nov_movie_app/domain/model/movie_list.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieLocalProvider {
  final Future<SharedPreferences> _futureSPref =
      SharedPreferences.getInstance();
  final kFavouriteMovies = 'favourite_movies';
  final kMovieList = 'movie_list';

  Future<MovieList?> fetchAllMovies() async {
    var sharedPreference = await _futureSPref;

    var content = sharedPreference.getString(kMovieList);
    if (content == null) {
      return null;
    }

    return json.decode(content) as MovieList;
  }

  Future<bool> saveAsCache(MovieList result) async {
    var sharedPreference = await _futureSPref;

    var content = json.encode(result);
    return sharedPreference.setString(kMovieList, content);
  }

  Future toggleFavourite(Movie movie) async {
    var movies = await fetchFavouriteMovie();
    if (!movies.map((e) => e.id).contains(movie.id)) {
      movies.add(movie);
    } else {
      movies.removeWhere((element) => element.id == movie.id);
    }

    return _saveFavouriteMovie(movies);
  }

  Future _saveFavouriteMovie(Set<Movie> movies) async {
    var sharedPreference = await _futureSPref;

    var content = json.encode(movies.toList());

    await sharedPreference.setString(kFavouriteMovies, content);
  }

  Future<Set<Movie>> fetchFavouriteMovie() async {
    var sharedPreference = await _futureSPref;
    var content = sharedPreference.getString(kFavouriteMovies);
    if (content == null) {
      return {};
    }

    return (json.decode(content) as List)
        .cast()
        .map((e) => Movie.fromJson(e))
        .toSet();
  }
}
