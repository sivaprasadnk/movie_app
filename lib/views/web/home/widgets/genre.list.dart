import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:provider/provider.dart';

class GenreOptionsList extends StatelessWidget {
  const GenreOptionsList({
    super.key,
    required this.genreList,
    this.isMovie = true,
    this.isPopular = false,
  });

  final List<MovieGenre> genreList;
  final bool isMovie;
  final bool isPopular;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        var selected = provider.selectedGenre;
        return Wrap(
          direction: Axis.horizontal,
          children: genreList.map((genre) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  provider.updateGenre(genre, isMovie, isPopular);
                },
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: genre.id == selected.id
                        ? context.theme.primaryColor
                        : Colors.white,
                    border: Border.all(
                      color: context.theme.primaryColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      genre.name,
                      style: TextStyle(
                        color: genre.id != selected.id
                            ? context.theme.primaryColor
                            : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
