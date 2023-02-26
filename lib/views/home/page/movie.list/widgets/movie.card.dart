import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:movie_app/views/home/page/movie.list/movie/movie.details.screen.dart';
import 'package:movie_app/views/home/page/movie.list/movie/tv.show.details.screen.dart';

import '../../../../../utils/dialogs.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.poster,
    required this.name,
    required this.vote,
    required this.id,
    this.isMovie = true,
  }) : super(key: key);

  final String poster;
  final String name;
  final double vote;
  final int id;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    var cacheKey = "movie$id$name";
    if (!isMovie) {
      cacheKey = "tvshow$id$name";
    }
    return GestureDetector(
      onTap: () {
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
      },
      child: SizedBox(
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ClipRRect(
            //   borderRadius: const BorderRadius.all(
            //     Radius.circular(8),
            //   ),
            //   child: Image.network(
            //     poster,
            //     height: 155,
            //     width: 100,
            //     fit: BoxFit.cover,
            //     errorBuilder: (context, error, stackTrace) {
            //       return const SizedBox(
            //         height: 155,
            //         width: 100,
            //         child: Icon(Icons.error),
            //       );
            //     },
            //   ),
            // ),
            CustomCacheImage(
              borderRadius: 8,
              height: 155,
              width: 100,
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
