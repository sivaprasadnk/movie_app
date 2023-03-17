import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';

class MovieBackdropImage extends StatelessWidget {
  const MovieBackdropImage({super.key, required this.movie});

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) {
    var cacheKey = 'movie_${movie.id}details';

    return SizedBox(
      width: context.width > 800 ? context.width * 0.6 : double.infinity,
      child: CustomCacheImage(
        imageUrl: movie.backdropPath,
        height: context.height * 0.6,
        width: double.infinity,
        cacheKey: cacheKey,
        borderRadius: 0,
      ),
    );
  }
}
