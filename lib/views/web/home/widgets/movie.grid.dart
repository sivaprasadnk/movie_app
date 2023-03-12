import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.card.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({
    super.key,
    required this.isLoading,
    required this.movieGrid,
    this.isWeb = false,
    required this.limit,
  });

  final bool isLoading;
  final List<Movie> movieGrid;
  final bool isWeb;
  final int limit;

  @override
  Widget build(BuildContext context) {
    debugPrint('width : ${context.width}');
    return isLoading
        ? const SizedBox(
            height: 75,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : GridView.builder(
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
              var movie = movieGrid[index];
              return Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: MovieCard(
                  name: movie.title,
                  poster: movie.posterPath,
                  vote: movie.voteAverage,
                  id: movie.id,
                  isWeb: isWeb,
                  imageHeight: 200,
                  imageWidth: 150,
                ),
              );
            },
          );
  }
}
