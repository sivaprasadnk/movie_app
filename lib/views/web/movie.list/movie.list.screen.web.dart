import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
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
    this.movieType = MovieType.nowPlaying,
    required this.title,
  }) : super(key: key);

  final bool isMobileWeb;
  final MovieType movieType;
  final String title;

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
                title: title,
                withSeeMore: false,
              ),
              const SizedBox(height: 20),
              movieType != MovieType.topRated
                  ? GenreOptionsList(
                      genreList: context.moviesProvider.movieGenreList
                          .movieGenres(context.moviesProvider.moviesList
                              .nowPlayingMovies(20)),
                    )
                  : GenreOptionsList(
                      genreList: context.moviesProvider.movieGenreList
                          .movieGenres(context.moviesProvider.moviesList
                              .popularMovies(20)),
                      movieType: MovieType.topRated,
                    ),
              const SizedBox(height: 20),
              Consumer<MoviesProvider>(
                builder: (_, provider, __) {
                  return movieType != MovieType.topRated
                      ? MovieGrid(
                          isLoading: false,
                          movieGrid:
                              provider.filteredMoviesList.nowPlayingMovies(20),
                          isWeb: true,
                          limit: provider.filteredMoviesList
                              .nowPlayingMovies(20)
                              .length,
                        )
                      : MovieGrid(
                          isLoading: false,
                          movieGrid:
                              provider.filteredMoviesList.popularMovies(20),
                          isWeb: true,
                          limit: provider.filteredMoviesList
                              .popularMovies(20)
                              .length,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
