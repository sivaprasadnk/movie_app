import 'package:flutter/material.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.card.dart';
import 'package:provider/provider.dart';

class OnTvGridWeb extends StatelessWidget {
  const OnTvGridWeb({
    Key? key,
    this.isGrid = false,
    this.limit = 0,
  }) : super(key: key);
  final bool isGrid;
  final int limit;
  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.onTVListLoading
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
                  // crossAxisCount: 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.5,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: context.gridCrossAxisCount,
                itemBuilder: (context, index) {
                  var movie = provider.onTvList.homeScreenList(limit)[index];
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
                    ),
                  );
                },
              );
      },
    );
  }
}
