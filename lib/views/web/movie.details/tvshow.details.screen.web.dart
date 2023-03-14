import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/web/movie.details/tvshow.details.large.dart';

class TvShowDetailsScreenWeb extends StatelessWidget {
  static const routeName = "/tvshow/";

  const TvShowDetailsScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    var movie = context.moviesProvider.selectedShow!;
    return Scaffold(
      appBar: const TitleAppBar(),
      body: SingleChildScrollView(
        child: context.width > 700
            ? TvShowDetailsLarge(show: movie)
            : TvShowDetailsLarge(show: movie),
      ),
    );
  }
}
