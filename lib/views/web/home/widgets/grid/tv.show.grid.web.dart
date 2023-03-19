import 'package:flutter/material.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/movie.card.dart';
import 'package:provider/provider.dart';

class TvShowGridWeb extends StatelessWidget {
  const TvShowGridWeb({
    Key? key,
    this.limit = 0,
    required this.showList,
  }) : super(key: key);
  final int limit;
  final List<TvShows> showList;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.tvShowListLoading
            ? const SizedBox(
                height: 75,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.gridCrossAxisCount,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.6,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: context.gridCrossAxisCount,
                itemBuilder: (context, index) {
                  var movie = showList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: MovieCard(
                      name: movie.name,
                      poster: movie.posterPath,
                      vote: movie.voteAverage,
                      id: movie.id,
                      isMovie: false,
                      isWeb: true,
                      imageHeight: 200,
                      imageWidth: 150,
                      withSize: false,
                    ),
                  );
                },
              );
      },
    );
  }
}
