import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/web/home/widgets/genre.list.dart';
import 'package:movie_app/views/web/home/widgets/grid/movie.grid.dart';
import 'package:provider/provider.dart';

class MovieListScreenWeb extends StatelessWidget {
  const MovieListScreenWeb({
    Key? key,
    this.isMobileWeb = false,
    this.movieType = MovieType.nowPlaying,
    required this.title,
    required this.genreList,
  }) : super(key: key);

  final bool isMobileWeb;
  final MovieType movieType;
  final String title;
  final List<Genre> genreList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.1,
            right: context.width * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SectionTitle(
                title: title,
                withSeeMore: false,
                withSettings: true,
                settingsCallBack: () {
                  showSettingsDialog(
                    context,
                    context.moviesProvider.selectedSort,
                  );
                },
              ),
              const SizedBox(height: 20),
              GenreOptionsList(
                genreList: genreList,
                movieType: movieType,
              ),
              const SizedBox(height: 20),
              Consumer<MoviesProvider>(builder: (_, provider, __) {
                return MovieGrid(
                  isLoading: false,
                  movieGrid: provider.filteredMoviesList,
                  isWeb: true,
                  limit: provider.filteredMoviesList.length,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future showSettingsDialog(
      BuildContext context, String currentSettings) async {
    var primaryColor = context.theme.primaryColor;
    var whiteColor = Colors.white;

    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        var selected = currentSettings;
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const SectionTitle(title: 'Settings'),
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
              width: context.width * 0.3,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Sort by'),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Wrap(
                      children: sortBy.values.map((order) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = order.displayTitle;
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: selected == order.displayTitle
                                  ? primaryColor
                                  : whiteColor,
                              border: Border.all(
                                color: context.theme.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                order.displayTitle,
                                style: TextStyle(
                                  color: selected == order.displayTitle
                                      ? whiteColor
                                      : primaryColor,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Text('Cancel'),
              ).addMousePointer,
            ),
            const SizedBox(width: 10),
            Consumer<MoviesProvider>(builder: (_, provider, __) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                    var list = provider.filteredMoviesList;
                    if (selected == sortBy.titleAscending.displayTitle) {
                      list.sort((a, b) => a.title.compareTo(b.title));
                    } else if (selected ==
                        sortBy.titleDescending.displayTitle) {
                      list.sort((a, b) => b.title.compareTo(a.title));
                    } else if (selected == sortBy.dateAscending.displayTitle) {
                      list.sort(
                          (a, b) => a.releaseDate.compareTo(b.releaseDate));
                    } else if (selected == sortBy.dateDescending.displayTitle) {
                      list.sort(
                          (a, b) => b.releaseDate.compareTo(a.releaseDate));
                    }
                    provider.updateSort(selected);
                    provider.updateFilteredMoviesList(list);
                  },
                  child: const Text('OK'),
                ).addMousePointer,
              );
            })
          ],
        );
      },
    );
  }
}
