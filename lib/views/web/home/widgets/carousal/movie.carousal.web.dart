import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';
import 'package:movie_app/views/common/carousal.indicator.dart';
import 'package:movie_app/views/common/loading.shimmer.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:movie_app/views/web/home/widgets/carousal/left.arrow.container.dart';
import 'package:movie_app/views/web/home/widgets/carousal/right.arrow.container.dart';
import 'package:movie_app/views/web/movie.details/movie.details.screen.web.dart';
import 'package:provider/provider.dart';

class MovieCarousalWeb extends StatefulWidget {
  const MovieCarousalWeb({super.key});

  @override
  State<MovieCarousalWeb> createState() => _MovieCarousalWebState();
}

class _MovieCarousalWebState extends State<MovieCarousalWeb> {
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return provider.moviesListLoading
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
                      items:
                          provider.moviesList.trendingMovies(10).map((movie) {
                        return GestureDetector(
                          onTap: () {
                            provider.getMovieDetails(movie.id).then((value) {
                              Navigator.pushNamed(
                                  context, MovieDetailsScreenWeb.routeName);
                            });
                          },
                          child: CarousalMovieItem(
                            isWeb: true,
                            id: movie.id.toString(),
                            backdropImage: movie.backdropPath,
                            title: movie.title,
                          ),
                        ).addMousePointer;
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
                  LeftArrowContainer(
                    controller: controller,
                    carousalIndex: provider.carousalIndex,
                  ),
                  RightArrowContainer(
                    controller: controller,
                    carousalIndex: provider.carousalIndex,
                  ),
                  CarousalIndicator(
                    carousalIndex: provider.carousalIndex,
                    movieList: provider.moviesList.trendingMovies(10),
                    isWeb: true,
                    isMovie: true,
                  )
                ],
              ),
            );
    });
  }
}
