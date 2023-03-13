import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/web/movie.details/movie.details.large.dart';
import 'package:movie_app/views/web/movie.details/movie.details.small.dart';

class MovieDetailsScreenWeb extends StatefulWidget {
  static const routeName = "/movie/";

  const MovieDetailsScreenWeb({super.key});

  @override
  State<MovieDetailsScreenWeb> createState() => _MovieDetailsScreenWebState();
}

class _MovieDetailsScreenWebState extends State<MovieDetailsScreenWeb> {
  @override
  Widget build(BuildContext context) {
    var movie = context.moviesProvider.selectedMovie!;
    return Scaffold(
      appBar: const TitleAppBar(),
      body: SingleChildScrollView(
        child: context.width > 700
            ? MovieDetailsLarge(movie: movie)
            : MovieDetailsSmall(movie: movie),
      ),
    );
  }
}
