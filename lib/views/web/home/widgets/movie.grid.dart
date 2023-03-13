import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.card.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({
    super.key,
    required this.isLoading,
    this.movieGrid = const [],
    this.tvShowsList = const [],
    required this.limit,
    this.isWeb = false,
    this.isMovie = true,
  });

  final bool isLoading;
  final List<Movie> movieGrid;
  final List<TvShows> tvShowsList;
  final bool isWeb;
  final int limit;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            height: 75,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : movieGrid.isNotEmpty
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.gridCrossAxisCount,
                  // crossAxisCount: 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.5,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: limit,
                itemBuilder: (context, index) {
                  if (isMovie) {
                    var movie = movieGrid[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: MovieCard(
                        isMovie: true,
                        name: movie.title,
                        poster: movie.posterPath,
                        vote: movie.voteAverage,
                        id: movie.id,
                        isWeb: isWeb,
                        imageHeight: 200,
                        imageWidth: 150,
                      ),
                    );
                  } else {
                    var show = tvShowsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: MovieCard(
                        isMovie: false,
                        name: show.name,
                        poster: show.posterPath,
                        vote: show.voteAverage,
                        id: show.id,
                        isWeb: isWeb,
                        imageHeight: 200,
                        imageWidth: 150,
                      ),
                    );
                  }
                },
              )
            : const SizedBox.shrink();
  }
}
