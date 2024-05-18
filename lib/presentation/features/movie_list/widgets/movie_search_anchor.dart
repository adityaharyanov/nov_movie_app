import 'package:flutter/material.dart';
import 'package:nov_movie_app/presentation/features/movie_list/movie_list.viewmodel.dart';
import 'package:nov_movie_app/presentation/features/movie_list/widgets/movie_item_card.dart';

class MovieSearchAnchor extends StatelessWidget {
  final MovieListViewModel viewModel;
  const MovieSearchAnchor({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      controller.addListener(() {
        viewModel.query.value = controller.text;
      });
      return SearchBar(
        hintText: "Search Movie",
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          controller.closeView(value);
          viewModel.query.value = "";
        },
        controller: controller,
        padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0)),
        onTap: () {
          controller.openView();
        },
        onChanged: (_) {
          controller.openView();
        },
        leading: const Icon(Icons.search),
      );
    }, suggestionsBuilder:
            (BuildContext context, SearchController controller) async {
      return viewModel.filteredMovies
          .map((element) => MovieItemCard(movie: element));
    });
  }
}
