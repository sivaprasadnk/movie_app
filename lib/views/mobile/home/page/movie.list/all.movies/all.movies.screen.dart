import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/web/home/widgets/genre.list.dart';
import 'package:movie_app/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({
    super.key,
    this.title = 'Popular Movies',
    required this.type,
    required this.genreList,
  });

  final String title;
  final MovieType type;
  final List<Genre> genreList;

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
                GenreOptionsList(
                  genreList: genreList,
                  movieType: type,
                ),
                const SizedBox(height: 20),
                Consumer<MoviesProvider>(
                  builder: (_, provider, __) {
                    return MovieGrid(
                      isLoading: false,
                      movieGrid: provider.filteredMoviesList,
                      isWeb: false,
                      limit: provider.filteredMoviesList.length,
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