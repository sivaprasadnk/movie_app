import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/home/page/movie.list/widgets/movie.list.dart';
import 'package:provider/provider.dart';

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return MovieList(
          isLoading: provider.popularListLoading,
          movieList: provider.popularMovieList.homeScreenList,
        );
      },
    );
  }
}
