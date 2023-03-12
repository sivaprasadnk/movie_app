import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.list.dart';
import 'package:provider/provider.dart';

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList({
    super.key,
    this.isWeb = false,
  });
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    var limit = isWeb ? 10 : 5;

    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return MovieList(
          isLoading: provider.popularListLoading,
          movieList: provider.popularMovieList.homeScreenList(limit),
        );
      },
    );
  }
}
