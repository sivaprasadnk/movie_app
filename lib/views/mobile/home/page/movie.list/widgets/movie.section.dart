import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/all.movies/all.movies.screen.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/now.playing.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/popular.movies.list.dart';

class MovieSectionMobile extends StatelessWidget {
  const MovieSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Now Playing',
          withSeeMore: true,
          seeMoreCallBack: () {
            context.moviesProvider.updateMovieGenre(
              Genre(id: 0, name: 'All'),
              MovieType.nowPlaying,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AllMoviesScreen(
                  title: 'Now Playing',
                  type: MovieType.nowPlaying,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const NowPlayingListMobile(limit: 5),
        const SizedBox(height: 20),
        SectionTitle(
          title: 'Popular Movies',
          withSeeMore: true,
          seeMoreCallBack: () {
            context.moviesProvider.updateMovieGenre(
              Genre(id: 0, name: 'All'),
              MovieType.topRated,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AllMoviesScreen(
                  title: 'Popular Movies',
                  type: MovieType.topRated,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const PopularMoviesList(),
      ],
    );
  }
}
