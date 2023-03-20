import 'package:flutter/material.dart';

class MovieRatingDetailsMobile extends StatelessWidget {
  const MovieRatingDetailsMobile({
    super.key,
    required this.voteAverage,
    required this.voteCount,
  });

  final String voteAverage;
  final String voteCount;

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
              voteAverage,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "( $voteCount )",
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
