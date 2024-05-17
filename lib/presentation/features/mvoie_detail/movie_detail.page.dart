import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nov_movie_app/router/routes.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  void _pushMovieDetailPage(BuildContext context) {
    context.push(Routes.movieDetail.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        child: Center(
          child: ElevatedButton(
            onPressed: () => _pushMovieDetailPage(context),
            child: const Text("Go to Movie Detail"),
          ),
        ));
  }
}
