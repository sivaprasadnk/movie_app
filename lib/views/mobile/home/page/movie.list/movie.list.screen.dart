import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.indicator.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/now.playing.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/ontv.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/popular.movies.list.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<MoviesProvider>(
            builder: (_, provider, __) {
              return provider.trendingListLoading
                  ? const SizedBox.shrink()
                  : Stack(
                      children: [
                        SizedBox(
                          height: context.height * 0.4,
                          width: double.infinity,
                          child: FlutterCarousel(
                            items: provider.carousalMovieList.map((movie) {
                              return CarousalMovieItem(movie: movie);
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
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
                        )
                      ],
                    );
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Column(
              children: [
                SectionTitle(
                  title: 'Now Playing',
                  withSeeMore: true,
                  seeMoreCallBack: () {},
                ),
                const SizedBox(height: 20),
                const NowPlayingList(),
                const SizedBox(height: 20),
                SectionTitle(
                  title: 'On TV',
                  withSeeMore: true,
                  seeMoreCallBack: () {},
                ),
                const SizedBox(height: 20),
                const OnTvList(),
                const SizedBox(height: 20),
                SectionTitle(
                  title: 'Popular Movies',
                  withSeeMore: true,
                  seeMoreCallBack: () {},
                ),
                const SizedBox(height: 20),
                const PopularMoviesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
