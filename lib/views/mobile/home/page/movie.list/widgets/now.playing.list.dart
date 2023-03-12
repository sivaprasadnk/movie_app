import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.list.dart';
import 'package:movie_app/views/web/home/widgets/movie.grid.dart';
import 'package:provider/provider.dart';

class NowPlayingListMobile extends StatelessWidget {
  const NowPlayingListMobile({
    Key? key,
    this.isGrid = false,
    this.limit = 0,
  }) : super(key: key);
  final bool isGrid;
  final int limit;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return !isGrid
            ? MovieList(
                isLoading: provider.nowPlayingListLoading,
                movieList: provider.nowPlayingList.homeScreenList(limit),
                isWeb: false,
              )
            : MovieGrid(
                isLoading: provider.nowPlayingListLoading,
                movieGrid: provider.nowPlayingList.homeScreenList(limit),
                isWeb: true,
                limit: limit,
              );
      },
    );
  }
}
