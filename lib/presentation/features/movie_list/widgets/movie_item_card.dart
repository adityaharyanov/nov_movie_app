import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:nov_movie_app/presentation/features/movie_list/movie_item.viewmodel.dart';
import 'package:nov_movie_app/presentation/features/movie_list/widgets/image_view.dart';

class MovieItemCard extends StatelessWidget {
  final MovieItemViewModel movie;
  final void Function(BuildContext context)? onTap;

  const MovieItemCard({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(context),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: Stack(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageView(url: movie.posterUrl),
              const SizedBox(width: 10.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(movie.releaseDate),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Obx(() => IconButton(
                onPressed: movie.toggleFavourite,
                icon: Icon(
                  Icons.favorite,
                  color: movie.favouriteIconColor,
                  size: 30,
                ))),
          )
        ]),
      ),
    );
  }
}
