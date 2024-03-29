import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/dialogs.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/web/home/widgets/genre.list.dart';
import 'package:movie_app/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class AllTvShowsScreen extends StatelessWidget {
  const AllTvShowsScreen({
    super.key,
    required this.title,
    required this.type,
    required this.genreList,
  });

  final String title;
  final TvShowType type;
  final List<Genre> genreList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 50,
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: context.theme.primaryColor,
            ),
          ),
          title: SectionTitle(title: title),
          actions: [
            GestureDetector(
              onTap: () {
                Dialogs.showSortByDialog(
                  context,
                  context.moviesProvider.selectedSort,
                  isMovie: false,
                );
              },
              child: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GenreOptionsList(
                  isMovie: false,
                  genreList: genreList,
                  tvShowType: type,
                ),
                const SizedBox(height: 20),
                Consumer<MoviesProvider>(
                  builder: (_, provider, __) {
                    return MovieGrid(
                      isLoading: false,
                      isMovie: false,
                      tvShowsList: provider.filteredTvShowsList,
                      isWeb: false,
                      limit: provider.filteredTvShowsList.length,
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
