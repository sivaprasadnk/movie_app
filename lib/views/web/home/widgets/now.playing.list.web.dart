import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/web/home/widgets/movie.grid.dart';
import 'package:provider/provider.dart';

class NowPlayingListWeb extends StatelessWidget {
  const NowPlayingListWeb({
    Key? key,
    this.isGrid = false,
    this.limit = 0,
    this.isPopularMovies = false,
  }) : super(key: key);
  final bool isGrid;
  final int limit;
  final bool isPopularMovies;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return !isPopularMovies
            ? MovieGrid(
                isLoading: provider.nowPlayingListLoading,
                movieGrid: provider.nowPlayingList.homeScreenList(limit),
                isWeb: true,
                limit: context.gridCrossAxisCount,
              )
            : MovieGrid(
                isLoading: provider.popularListLoading,
                movieGrid: provider.popularMovieList.homeScreenList(limit),
                isWeb: true,
                limit: context.gridCrossAxisCount,
              );
      },
    );
  }
}
