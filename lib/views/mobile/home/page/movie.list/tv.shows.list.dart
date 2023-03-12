import 'package:flutter/material.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.card.dart';
import 'package:provider/provider.dart';

class TvShowList extends StatelessWidget {
  const TvShowList({
    super.key,
    required this.isLoading,
    required this.showList,
  });

  final bool isLoading;
  final List<TvShows> showList;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return isLoading
            ? const SizedBox(
                height: 75,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(
                height: 205,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: showList.length,
                  itemBuilder: (context, index) {
                    var movie = showList[index];
                    return MovieCard(
                      name: movie.name,
                      poster: movie.posterPath,
                      vote: movie.voteAverage,
                      id: movie.id,
                      isMovie: false,
                    );
                  },
                ),
              );
      },
    );
  }
}
