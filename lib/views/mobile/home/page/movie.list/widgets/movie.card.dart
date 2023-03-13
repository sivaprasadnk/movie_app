import 'package:flutter/material.dart';
import 'package:movie_app/utils/dialogs.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/movie.details.screen.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/tv.show.details.screen.dart';
import 'package:movie_app/views/web/movie.details/movie.details.screen.web.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.poster,
    required this.name,
    required this.vote,
    required this.id,
    this.isMovie = true,
    this.isWeb = false,
    this.imageHeight = 155,
    this.imageWidth = 100,
  }) : super(key: key);

  final String poster;
  final String name;
  final double vote;
  final int id;
  final bool isMovie;
  final bool isWeb;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    var cacheKey = "movie$id$name";
    if (!isMovie) {
      cacheKey = "tvshow$id$name";
    }
    return GestureDetector(
      onTap: () {
        if (!isWeb) {
          Dialogs.showLoader(context: context);
          context.moviesProvider.clearActorsAndSimilarList();

          if (isMovie) {
            context.moviesProvider.getMovieDetails(id).then((value) {
              context.pop();
              Navigator.pushNamed(context, MovieDetailsScreen.routeName);
            });
          } else {
            context.moviesProvider.getTvShowDetails(id).then((value) {
              context.pop();
              Navigator.pushNamed(context, TvShowDetailsScreen.routeName);
            });
          }
        } else {
          if (isMovie) {

            context.moviesProvider.getMovieDetails(id).then((value) {
              Navigator.pushNamed(context, MovieDetailsScreenWeb.routeName);
            });
          } else {
            context.moviesProvider.getTvShowDetails(id).then((value) {
              context.pop();
              Navigator.pushNamed(context, TvShowDetailsScreen.routeName);
            });
          }
        }
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            !isWeb
                ? CustomCacheImage(
                    borderRadius: 8,
                    height: imageHeight,
                    width: imageWidth,
                    imageUrl: poster,
                    cacheKey: cacheKey,
                  )
                : CustomCacheImageWithoutSize(
                    borderRadius: 8,
                    // height: imageHeight,
                    // width: imageWidth,
                    imageUrl: poster,
                    cacheKey: cacheKey,
                  ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '1h 37m',
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 10,
                ),
                Text(
                  vote.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
