import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';
import 'package:movie_app/views/common/carousal.indicator.dart';
import 'package:movie_app/views/common/loading.shimmer.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:movie_app/views/web/home/widgets/carousal/left.arrow.container.dart';
import 'package:movie_app/views/web/home/widgets/carousal/right.arrow.container.dart';
import 'package:movie_app/views/web/movie.details/tvshow.details.screen.web.dart';
import 'package:provider/provider.dart';

class TvShowCarousalWeb extends StatefulWidget {
  const TvShowCarousalWeb({super.key});

  @override
  State<TvShowCarousalWeb> createState() => _TvShowCarousalWebState();
}

class _TvShowCarousalWebState extends State<TvShowCarousalWeb> {
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      return provider.tvShowListLoading
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
                      items: provider.tvShowsList.trendingShows(10).map((show) {
                        return GestureDetector(
                          onTap: () {
                            provider.getTvShowDetails(show.id).then((value) {
                              Navigator.pushNamed(
                                  context, TvShowDetailsScreenWeb.routeName);
                            });
                          },
                          child: CarousalMovieItem(
                            isWeb: true,
                            backdropImage: show.backdropPath,
                            id: show.id.toString(),
                            title: show.name,
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
                    showList: provider.tvShowsList.trendingShows(10),
                    isWeb: true,
                    isMovie: false,
                  )
                ],
              ),
            );
    });
  }
}
