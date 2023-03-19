import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.details.dart';

class MovieRatingDetailsMobile extends StatelessWidget {
  const MovieRatingDetailsMobile({super.key, required this.movie});

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 10,
      left: 20,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              movie.voteAverage.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "( ${movie.voteCount} )",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
