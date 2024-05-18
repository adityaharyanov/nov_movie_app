import 'package:get/get.dart';
import 'package:nov_movie_app/data/repositories/movie.repository.dart';
import 'package:nov_movie_app/domain/model/movie.model.dart';
import 'package:nov_movie_app/helper/stream_ext.dart';
import 'package:nov_movie_app/presentation/features/movie_list/movie_item.viewmodel.dart';

class MovieListViewModel extends GetxController {
  final MovieRepository _repository;

  RxBool isLoading = false.obs;

  RxList<MovieItemViewModel> movies = <MovieItemViewModel>[].obs;
  RxList<MovieItemViewModel> favouriteMovies = <MovieItemViewModel>[].obs;
  RxList<MovieItemViewModel> filteredMovies = <MovieItemViewModel>[].obs;

  RxString query = ''.obs;

  MovieListViewModel({required MovieRepository repository})
      : _repository = repository {
    query.stream.throttle(const Duration(seconds: 1)).listen((event) async {
      if (event.isEmpty) {
        filteredMovies.value = movies.take(10).toList();
        return;
      }

      await _search(event);
    });
  }

  init() async {
    isLoading.value = true;
    await fetchMovies();
    await fetchFavourite();
    isLoading.value = false;
  }

  Future fetchMovies() async {
    var movies = await _repository.fetchAllMovies();

    this.movies.value = movies.results
        .map((e) => MovieItemViewModel(movie: e, parentViewModel: this))
        .toList();
  }

  Future fetchFavourite() async {
    var movies = await _repository.fetchFavouriteMovies();

    favouriteMovies.value = movies
        .map((e) => MovieItemViewModel(movie: e, parentViewModel: this))
        .toList();
  }

  Future _search(String query) async {
    var movies = await _repository.searchMovies(query);
    filteredMovies.value = movies
        .map((e) => MovieItemViewModel(movie: e, parentViewModel: this))
        .toList();
  }

  Future addFavourite(Movie movie) async {
    if (isLoading.value) return;

    await _repository.toggleFavourite(movie);
    await fetchFavourite();
  }
}
