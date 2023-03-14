import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/loading.shimmer.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.indicator.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:movie_app/views/web/movie.details/movie.details.screen.web.dart';
import 'package:provider/provider.dart';

class TrendingMovieCarousalWeb extends StatelessWidget {
  const TrendingMovieCarousalWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.trendingListLoading
            ? Center(
                child: LoadingShimmer(
                  child: Container(
                    color: Colors.black,
                    height: context.height * 0.6,
                    width: context.width * 0.5,
                  ),
                ),
              )
            : Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: context.height * 0.6,
                      child: FlutterCarousel(
                        items: provider.carousalMovieList.map((movie) {
                          return GestureDetector(
                            onTap: () {
                              provider.getMovieDetails(movie.id).then((value) {
                                Navigator.pushNamed(
                                    context, MovieDetailsScreenWeb.routeName);
                              });
                            },
                            child: CarousalMovieItem(
                              movie: movie,
                              isWeb: true,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          aspectRatio: 1.777,
                          enableInfiniteScroll: true,
                          showIndicator: false,
                          onPageChanged: (index, reason) {
                            provider.updateCarousalIndex(index);
                          },
                        ),
                      ),
                    ),
                    CarousalIndicator(
                      carousalIndex: provider.carousalIndex,
                      movieList: provider.carousalMovieList,
                      isWeb: true,
                    )
                  ],
                ),
              );
      },
    );
  }
}
