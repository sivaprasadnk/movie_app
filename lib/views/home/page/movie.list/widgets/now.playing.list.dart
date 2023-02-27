import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/home/page/movie.list/widgets/movie.list.dart';
import 'package:provider/provider.dart';

class NowPlayingList extends StatelessWidget {
  const NowPlayingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return MovieList(
          isLoading: provider.nowPlayingListLoading,
          movieList: provider.nowPlayingList.homeScreenList,
        );

      },
    );
  }
}
