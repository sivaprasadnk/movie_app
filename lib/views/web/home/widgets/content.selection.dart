import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';
import 'package:provider/provider.dart';

class ContentSelectionWeb extends StatelessWidget {
  const ContentSelectionWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.theme.primaryColor;
    var whiteColor = Colors.white;
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      var selected = provider.selectedContentType;
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
                color: selected == Content.movie ? whiteColor : primaryColor,
                border: Border.all(
                  color: context.theme.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'Movies',
                  style: TextStyle(
                    color:
                        selected != Content.movie ? whiteColor : primaryColor,
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
                color: selected == Content.tvShow ? whiteColor : primaryColor,
                border: Border.all(
                  color: context.theme.primaryColor,
                ),
              ),
              child: Center(
                child: Text(
                  'Tv Shows',
                  style: TextStyle(
                    color:
                        selected != Content.tvShow ? whiteColor : primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ).addMousePointer,
        ],
      );
    });
  }
}
