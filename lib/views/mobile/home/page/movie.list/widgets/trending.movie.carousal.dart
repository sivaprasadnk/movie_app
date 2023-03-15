import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/dialogs.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/loading.shimmer.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/movie.details.screen.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.indicator.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:provider/provider.dart';

class TrendingMovieCarousal extends StatelessWidget {
  const TrendingMovieCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: provider.trendingListLoading
              ? Center(
                  child: LoadingShimmer(
                    child: Container(
                      color: Colors.black,
                      height: context.height * 0.26,
                      width: double.infinity,
                    ),
                  ),
                )
              : Center(
                  child: Stack(
                    children: [
                      FlutterCarousel(
                        items: provider.carousalMovieList.map((movie) {
                          return GestureDetector(
                            onTap: () {
                              Dialogs.showLoader(context: context);

                              provider.getMovieDetails(movie.id).then((value) {
                                context.pop();

                                Navigator.pushNamed(
                                    context, MovieDetailsScreen.routeName);
                              });
                            },
                            child: CarousalMovieItem(movie: movie),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          aspectRatio: 1.777,
                          enableInfiniteScroll: true,
                          showIndicator: false,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            provider.updateCarousalIndex(index);
                          },
                        ),
                      ),
                      CarousalIndicator(
                        carousalIndex: provider.carousalIndex,
                        movieList: provider.carousalMovieList,
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
