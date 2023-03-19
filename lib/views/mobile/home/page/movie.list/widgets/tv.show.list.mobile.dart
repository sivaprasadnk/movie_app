import 'package:flutter/material.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/tv.shows.list.dart';
import 'package:provider/provider.dart';

class TvShowsListMobile extends StatelessWidget {
  const TvShowsListMobile({
    super.key,
    this.isWeb = false,
    required this.showType,
  });
  final bool isWeb;
  final TvShowType showType;

  @override
  Widget build(BuildContext context) {
    var limit = isWeb ? 10 : 5;

    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return TvShowList(
          isLoading: provider.tvShowListLoading,
          showList: showType == TvShowType.popular
              ? provider.tvShowsList.popularShows(limit)
              : showType == TvShowType.airingToday
                  ? provider.tvShowsList.airingTodayShows(limit)
                  : provider.tvShowsList.topRatedShows(limit),
        );
      },
    );
  }
}
