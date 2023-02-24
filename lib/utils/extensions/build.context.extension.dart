import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:provider/provider.dart';

extension ContextExtensions on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;

  MoviesProvider get moviesProvider =>
      Provider.of<MoviesProvider>(this, listen: false);
}
