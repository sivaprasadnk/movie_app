
import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';

class CarousalMovieItem extends StatelessWidget {
  const CarousalMovieItem({
    super.key,
    required this.movie,
    this.isWeb = false,
  });

  final Movie movie;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    var cacheKey = "carousal${movie.id}${movie.title}";
    return Stack(
      children: [
        CustomCacheImageWithoutSize(
          imageUrl: movie.backdropPath,
          cacheKey: cacheKey,
          borderRadius: 0,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 40,
          left: 20,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              movie.title,
              maxLines: 3,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}
