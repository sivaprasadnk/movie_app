import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/web/home.screen.web.dart';
import 'package:movie_app/views/web/movie.details/movie.details.small.dart';
import 'package:movie_app/views/web/movie.details/moview.details.large.dart';
import 'package:movie_app/views/web/user.name.container.dart';

class MovieDetailsScreenWeb extends StatefulWidget {
  static const routeName = "/MovieDetailsWeb";

  const MovieDetailsScreenWeb({super.key});

  @override
  State<MovieDetailsScreenWeb> createState() => _MovieDetailsScreenWebState();
}

class _MovieDetailsScreenWebState extends State<MovieDetailsScreenWeb> {
  @override
  Widget build(BuildContext context) {
    var movie = context.moviesProvider.selectedMovie!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreenWeb.routeName, (route) => false);
          },
          child: SizedBox(
            // width: context.width * 0.6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "MovieVerse",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        actions: const [
          UserDetailsContainer(),
          SizedBox(width: 50),
        ],
      ),
      body: SingleChildScrollView(
        child: context.width > 700
            ? MovieDetailsLarge(movie: movie)
            : MovieDetailsSmall(movie: movie),
      ),
    );
  }
}
