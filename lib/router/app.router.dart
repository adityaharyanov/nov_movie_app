import 'package:go_router/go_router.dart';
import 'package:nov_movie_app/presentation/features/movie_list/movie_list.page.dart';
import 'package:nov_movie_app/presentation/features/mvoie_detail/movie_detail.page.dart';
import 'package:nov_movie_app/router/routes.dart';

class AppRouter {
  late GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: Routes.movieList.path,
      routes: [
        _movieListRoute(),
        _movieDetailRoute(),
      ],
    );
  }

  GoRoute _movieListRoute() {
    return GoRoute(
      path: Routes.movieList.path,
      builder: (context, state) {
        return const MovieDetailPage();
      },
    );
  }

  GoRoute _movieDetailRoute() {
    return GoRoute(
      path: Routes.movieDetail.path,
      builder: (context, state) {
        return const MovieListPage();
      },
    );
  }
}
