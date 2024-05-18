import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:nov_movie_app/domain/model/movie.model.dart';
import 'package:nov_movie_app/presentation/features/movie_list/movie_item.viewmodel.dart';
import 'package:nov_movie_app/presentation/features/movie_list/movie_list.viewmodel.dart';
import 'package:nov_movie_app/presentation/features/movie_list/widgets/image_view.dart';
import 'package:nov_movie_app/presentation/features/movie_list/widgets/movie_item_card.dart';
import 'package:nov_movie_app/presentation/features/movie_list/widgets/movie_search_anchor.dart';
import 'package:nov_movie_app/router/routes.dart';

class MovieListPage extends StatefulWidget {
  final MovieListViewModel viewModel;
  const MovieListPage({super.key, required this.viewModel});

  @override
  State<MovieListPage> createState() => _MovieListPageState(viewModel);
}

class _MovieListPageState extends State<MovieListPage> {
  final MovieListViewModel viewModel;

  _MovieListPageState(this.viewModel);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.init();
  }

  void _pushMovieDetailPage(BuildContext context) {
    // context.push(Routes.movieDetail.path);
  }

  Widget _carouselSection(BuildContext context) {
    if (viewModel.favouriteMovies.isEmpty) return const SizedBox.shrink();

    var pageController = PageController(
      viewportFraction: 0.8,
      keepPage: true,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Favourite Movies',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 10,
        ),
        AspectRatio(
          aspectRatio: 1,
          child: SizedBox(
            child: PageView.builder(
                itemCount: viewModel.favouriteMovies.length,
                pageSnapping: true,
                controller: pageController,
                itemBuilder: (context, pagePosition) {
                  return Container(
                      width: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Image.network(
                        viewModel.favouriteMovies[pagePosition].posterUrl,
                        fit: BoxFit.fitHeight,
                      ));
                }),
          ),
        ),
      ],
    );
  }

  Widget _movieListSection(BuildContext context) {
    return Obx(() => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return MovieItemCard(movie: viewModel.movies[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: viewModel.movies.length));
  }

  Widget _space() {
    return const SizedBox(height: 16.0);
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Movie List',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Obx(() {
          if (viewModel.isLoading.value) {
            return _loading();
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey.shade700,
                child: Column(
                  children: [
                    MovieSearchAnchor(viewModel: viewModel),
                    _space(),
                    _carouselSection(context),
                    _space(),
                    _movieListSection(context),
                  ],
                ),
              ),
            );
          }
        }));
  }
}
