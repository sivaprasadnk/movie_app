import 'package:flutter/material.dart';
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
  }) : super(key: key);

  final bool isMobileWeb;

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
              const SectionTitle(
                title: 'Now Playing',
                withSeeMore: false,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const GenreOptionsList(),
              const SizedBox(height: 20),
              Consumer<MoviesProvider>(builder: (_, provider, __) {
                return MovieGrid(
                  isLoading: false,
                  movieGrid: provider.filteredNowPlayingList,
                  isWeb: true,
                  limit: provider.filteredNowPlayingList.length,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
