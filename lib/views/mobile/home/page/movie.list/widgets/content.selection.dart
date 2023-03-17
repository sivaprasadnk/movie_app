import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';

class ContentSelection extends StatelessWidget {
  const ContentSelection({
    Key? key,
    required this.provider,
    required this.selected,
  }) : super(key: key);

  final MoviesProvider provider;
  final Content selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            provider.updateContentType(Content.movie);
          },
          child: Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
              color: selected == Content.movie
                  ? context.theme.primaryColor
                  : Colors.white,
              border: Border.all(
                color: context.theme.primaryColor,
              ),
            ),
            child: Center(
              child: Text(
                'Movies',
                style: TextStyle(
                  color: selected != Content.movie
                      ? context.theme.primaryColor
                      : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ).addMousePointer,
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            provider.updateContentType(Content.tvShow);
          },
          child: Container(
            width: 90,
            height: 40,
            decoration: BoxDecoration(
              color: selected == Content.tvShow
                  ? context.theme.primaryColor
                  : Colors.white,
              border: Border.all(
                color: context.theme.primaryColor,
              ),
            ),
            child: Center(
              child: Text(
                'Tv Shows',
                style: TextStyle(
                  color: selected != Content.tvShow
                      ? context.theme.primaryColor
                      : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ).addMousePointer
      ],
    );
  }
}
