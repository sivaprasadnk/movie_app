import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/web/home/widgets/genre.list.dart';
import 'package:movie_app/views/web/home/widgets/movie.grid.dart';
import 'package:provider/provider.dart';

class MovieListScreenWeb extends StatelessWidget {
  const MovieListScreenWeb({
    Key? key,
    this.isMobileWeb = false,
    this.isPopularMovies = false,
  }) : super(key: key);

  final bool isMobileWeb;
  final bool isPopularMovies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SectionTitle(
                title: !isPopularMovies ? 'Now Playing' : 'Popular Movies',
                withSeeMore: false,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              !isPopularMovies
                  ? GenreOptionsList(
                      genreList: context.moviesProvider.movieGenreList
                          .movieGenres(context.moviesProvider.nowPlayingList),
                    )
                  : GenreOptionsList(
                      genreList: context.moviesProvider.movieGenreList
                          .movieGenres(context.moviesProvider.popularMovieList),
                      isPopular: true,
                    ),
              const SizedBox(height: 20),
              Consumer<MoviesProvider>(
                builder: (_, provider, __) {
                  return !isPopularMovies
                      ? MovieGrid(
                          isLoading: false,
                          movieGrid: provider.filteredNowPlayingList,
                          isWeb: true,
                          limit: provider.filteredNowPlayingList.length,
                        )
                      : MovieGrid(
                          isLoading: false,
                          movieGrid: provider.filteredPopularMovies,
                          isWeb: true,
                          limit: provider.filteredPopularMovies.length,
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
