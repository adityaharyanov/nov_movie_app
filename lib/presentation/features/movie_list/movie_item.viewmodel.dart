// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:nov_movie_app/data/constants.dart';
import 'package:nov_movie_app/domain/model/movie.model.dart';
import 'package:nov_movie_app/presentation/features/movie_list/movie_list.viewmodel.dart';

class MovieItemViewModel {
  final Rx<Movie> movie;

  RxBool isFavourite = false.obs;

  MovieItemViewModel({
    required Movie movie,
    required MovieListViewModel parentViewModel,
  }) : movie = movie.obs {
    isFavourite.value = movie.isFavourite;
    isFavourite.stream.listen((event) async {
      await parentViewModel.addFavourite(movie);
    });
  }

  String get title => movie.value.title;

  String get overview => movie.value.overview;

  String get posterUrl => App.imageBaseUrl + movie.value.posterUrl;

  String get releaseDate => movie.value.releaseDate;

  Color get favouriteIconColor => isFavourite.value ? Colors.red : Colors.grey;

  void toggleFavourite() async {
    isFavourite.value = !isFavourite.value;
  }
}
