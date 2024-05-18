import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nov_movie_app/data/repositories/movie.repository.dart';
import 'package:nov_movie_app/domain/model/movie.model.dart';
import 'package:nov_movie_app/domain/model/movie_list.model.dart';

class MovieDummyProvider implements MovieDataProvider {
  @override
  Future<MovieList> fetchAllMovies(int page) {
    return _dummyData();
  }

  Future<MovieList> _dummyData() async {
    var path = 'lib/assets/mock_response.json';
    var raw = await rootBundle.loadString(path);
    Map<String, dynamic> decoded = json.decode(raw);

    return Future.delayed(
        const Duration(seconds: 2), () => MovieList.fromJson(decoded));
  }

  @override
  save(Movie movie) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}
