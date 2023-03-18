import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/web/home/widgets/genre.list.dart';
import 'package:movie_app/views/web/home/widgets/movie.grid.dart';
import 'package:provider/provider.dart';

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({
    super.key,
    this.title = 'Popular Movies',
    required this.type,
  });

  final String title;
  final MovieType type;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: context.theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                SectionTitle(title: title),
                const SizedBox(height: 20),
                type != MovieType.topRated
                    ? GenreOptionsList(
                        genreList:
                            context.moviesProvider.movieGenreList.movieGenres(
                          context.moviesProvider.moviesList
                              .nowPlayingMovies(20),
                        ),
                      )
                    : GenreOptionsList(
                        genreList:
                            context.moviesProvider.movieGenreList.movieGenres(
                          context.moviesProvider.moviesList.popularMovies(20),
                        ),
                        movieType: MovieType.topRated,
                      ),
                const SizedBox(height: 20),
                Consumer<MoviesProvider>(
                  builder: (_, provider, __) {
                    return type != MovieType.topRated
                        ? MovieGrid(
                            isLoading: false,
                            movieGrid: provider.filteredMoviesList
                                .nowPlayingMovies(20),
                            isWeb: false,
                            limit: provider.filteredMoviesList
                                .nowPlayingMovies(20)
                                .length,
                          )
                        : MovieGrid(
                            isLoading: false,
                            movieGrid:
                                provider.filteredMoviesList.popularMovies(20),
                            isWeb: false,
                            limit: provider.filteredMoviesList
                                .popularMovies(20)
                                .length,
                          );
                  },
                ),
                const SizedBox(height: 20),
                // Consumer<MoviesProvider>(
                //   builder: (_, provider, __) {
                //     var currentPage = provider.selectedPage;
                //     return Row(
                //       children: [
                //         GestureDetector(
                //           onTap: () {
                //             provider.decrementPage();
                //           },
                //           child: Icon(
                //             Icons.arrow_back_ios_new_rounded,
                //             color: context.theme.primaryColor,
                //             size: 25,
                //           ),
                //         ),
                //         const Spacer(),
                //         GestureDetector(
                //           onTap: () {
                //             provider.decrementPage();
                //           },
                //           child: Icon(
                //             Icons.arrow_forward_ios_rounded,
                //             color: context.theme.primaryColor,
                //             size: 25,
                //           ),
                //         )
                //       ],
                //     );
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
