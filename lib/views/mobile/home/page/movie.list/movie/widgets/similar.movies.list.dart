import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.list.dart';
import 'package:provider/provider.dart';

class SimilarMovieList extends StatelessWidget {
  const SimilarMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return MovieList(
          isLoading: provider.similarMovieListLoading,
          movieList: provider.similarMovieList,
        );
      },
    );
  }
}
