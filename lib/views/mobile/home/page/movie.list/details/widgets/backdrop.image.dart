import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';

class BackdropImageMobile extends StatelessWidget {
  const BackdropImageMobile({super.key, required this.movie});

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.network(
        movie.backdropPath,
        height: context.height * 0.4,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      ),
    );
  }
}
