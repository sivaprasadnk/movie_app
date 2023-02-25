import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/home/page/movie.list/widgets/movie.card.dart';
import 'package:provider/provider.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.isLoading,
    required this.movieList,
  });

  final bool isLoading;
  final List<Movie> movieList;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return isLoading
            ? const SizedBox(
                height: 75,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 205,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    var movie = movieList[index];
                    return MovieCard(
                      name: movie.title,
                      poster: movie.posterPath,
                      vote: movie.voteAverage,
                      id: movie.id,
                    );
                  },
                ),
              );
      },
    );
  }
}
