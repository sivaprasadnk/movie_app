import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';

class CarousalIndicator extends StatelessWidget {
  const CarousalIndicator({
    super.key,
    required this.carousalIndex,
    required this.movieList,
  });

  final int carousalIndex;
  final List<Movie> movieList;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: 20,
      bottom: 10,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: movieList.map((movie) {
            var i = movieList.indexOf(movie);
            return Container(
              width: carousalIndex == i ? 15 : 6.0,
              height: carousalIndex == i ? 7 : 6.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: carousalIndex == i
                    ? context.theme.primaryColor
                    : context.theme.primaryColor.withOpacity(0.4),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
