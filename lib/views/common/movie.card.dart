import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/dialogs.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/details/movie.details.screen.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/details/tv.show.details.screen.dart';
import 'package:movie_app/views/web/movie.details/movie.details.screen.web.dart';
import 'package:movie_app/views/web/movie.details/tvshow.details.screen.web.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({
    Key? key,
    required this.poster,
    required this.name,
    required this.vote,
    required this.id,
    required this.withSize,
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
  final bool withSize;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    var cacheKey = "movie${widget.id}${widget.name}";
    if (!widget.isMovie) {
      cacheKey = "tvshow${widget.id}${widget.name}";
    }
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return GestureDetector(
        onTap: () {
          Dialogs.showLoader(context: context);
          provider.clearActorsAndSimilarList();
          if (!widget.isWeb) {
            if (widget.isMovie) {
              provider.getMovieDetails(widget.id).then((value) {
                context.pop();
                Navigator.pushNamed(context, MovieDetailsScreen.routeName);
              });
            } else {
              provider.getTvShowDetails(widget.id).then((value) {
                context.pop();
                Navigator.pushNamed(context, TvShowDetailsScreen.routeName);
              });
            }
          } else {
            if (widget.isMovie) {
              debugPrint('id :: ${widget.id}');
              provider.getMovieDetails(widget.id).then((value) {
                // context.pop();
                Navigator.pushNamed(
                  context,
                  MovieDetailsScreenWeb.routeName,
                );
              });
            } else {
              provider.getTvShowDetails(widget.id).then((value) {
                context.pop();
                Navigator.pushNamed(context, TvShowDetailsScreenWeb.routeName);
              });
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.withSize
                ? CustomCacheImage(
                    borderRadius: 8,
                    height: widget.imageHeight,
                    width: widget.imageWidth,
                    imageUrl: widget.poster,
                    cacheKey: cacheKey,
                  )
                : CustomCacheImageWithoutSize(
                    borderRadius: 8,
                    imageUrl: widget.poster,
                    cacheKey: cacheKey,
                  ),
            const SizedBox(height: 5),
          ],
        ),
      );
    });
  }
}
