import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/carousal.indicator.dart';
import 'package:movie_app/views/common/loading.shimmer.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:movie_app/views/web/movie.details/movie.details.screen.web.dart';
import 'package:provider/provider.dart';

class TrendingMovieCarousalWeb extends StatefulWidget {
  const TrendingMovieCarousalWeb({super.key});

  @override
  State<TrendingMovieCarousalWeb> createState() =>
      _TrendingMovieCarousalWebState();
}

class _TrendingMovieCarousalWebState extends State<TrendingMovieCarousalWeb> {
  CarouselController controller = CarouselController();

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
                          controller: controller,
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
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            controller
                                .animateToPage(provider.carousalIndex - 1);
                          },
                          child: Container(
                            height: context.height * 0.12,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              gradient: LinearGradient(
                                begin: FractionalOffset.centerLeft,
                                end: FractionalOffset.centerRight,
                                colors: [
                                  Colors.white,
                                  Colors.transparent,
                                ],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_left,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            controller
                                .animateToPage(provider.carousalIndex + 1);
                          },
                          child: Container(
                            height: context.height * 0.12,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              gradient: LinearGradient(
                                begin: FractionalOffset.centerRight,
                                end: FractionalOffset.centerLeft,
                                colors: [
                                  Colors.white,
                                  Colors.transparent,
                                ],
                                stops: [0.0, 1.0],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
