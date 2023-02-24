import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/home/page/movie.list/widgets/movie.card.dart';
import 'package:provider/provider.dart';

class OnTvList extends StatelessWidget {
  const OnTvList({super.key});

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
            : SizedBox(
                height: 205,
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: provider.onTvList.length,
                  itemBuilder: (context, index) {
                    var movie = provider.onTvList[index];
                    return MovieCard(
                      name: movie.name,
                      poster: movie.posterPath,
                      vote: movie.voteAverage,
                    );
                  },
                ),
              );
      },
    );
  }
}
