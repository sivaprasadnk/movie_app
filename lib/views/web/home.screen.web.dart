import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/ontv.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/popular.movies.list.dart';
import 'package:movie_app/views/web/user.name.container.dart';
import 'package:provider/provider.dart';

import '../../provider/movies.provider.dart';
import '../mobile/home/page/movie.list/widgets/carousal.indicator.dart';
import '../mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import '../mobile/home/page/movie.list/widgets/now.playing.list.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  static const routeName = '/home';
  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.moviesProvider.getGenres();
      context.moviesProvider.getTrendingList();
      context.moviesProvider.getNowPlayingList();
      context.moviesProvider.getOnTvList();
      context.moviesProvider.getPopularList();
      context.appProvider.updatedSelectedIndex(0);
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            // width: context.width * 0.6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "MovieVerse",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 20),
                // Container(
                //   width: context.width * 0.5,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
              ],
            ),
          ),
          actions: const [
            UserDetailsContainer(),
            SizedBox(width: 50),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                                  return CarousalMovieItem(
                                    movie: movie,
                                    isWeb: true,
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  autoPlay: true,
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
                        );
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(
                  left: context.width * 0.1,
                ),
                child: Column(
                  children: [
                    SectionTitle(
                      title: 'Now Playing',
                      withSeeMore: true,
                      seeMoreCallBack: () {},
                    ),
                    const SizedBox(height: 20),
                    const NowPlayingList(
                      isWeb: true,
                    ),
                    const SizedBox(height: 20),
                    SectionTitle(
                      title: 'On TV',
                      withSeeMore: true,
                      seeMoreCallBack: () {},
                    ),
                    const SizedBox(height: 20),
                    const OnTvList(
                      isWeb: true,
                    ),
                    const SizedBox(height: 20),
                    SectionTitle(
                      title: 'Popular Movies',
                      withSeeMore: true,
                      seeMoreCallBack: () {},
                    ),
                    const SizedBox(height: 20),
                    const PopularMoviesList(
                      isWeb: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
