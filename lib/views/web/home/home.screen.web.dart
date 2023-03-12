import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/web/home/widgets/now.playing.list.web.dart';
import 'package:movie_app/views/web/home/widgets/ontv.grid.web.dart';
import 'package:provider/provider.dart';

import '../../../provider/movies.provider.dart';
import '../../mobile/home/page/movie.list/widgets/carousal.indicator.dart';
import '../../mobile/home/page/movie.list/widgets/carousal.movie.item.dart';
import '../movie.list/movie.list.screen.web.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({
    Key? key,
    this.isMobileWeb = false,
  }) : super(key: key);

  final bool isMobileWeb;

  static const routeName = '/home';
  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.appProvider.updateMobileApp(false);

      context.moviesProvider.getGenres();
      context.moviesProvider.getTrendingList();
      context.moviesProvider.getNowPlayingList();
      context.moviesProvider.getOnTvList();
      context.moviesProvider.getPopularList();
      context.appProvider.updatedSelectedIndex(0);
      context.appProvider.updateMobileWeb(widget.isMobileWeb);
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: const TitleAppBar(),
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
                      seeMoreCallBack: () {
                        context.moviesProvider
                            .updateGenre(MovieGenre(id: 0, name: 'All'));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return MovieListScreenWeb(
                                isMobileWeb: widget.isMobileWeb,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const NowPlayingListWeb(
                      limit: 5,
                      isGrid: true,
                    ),
                    SectionTitle(
                      title: 'Tv Shows',
                      withSeeMore: true,
                      seeMoreCallBack: () {
                        // var movieList = context.moviesProvider.nowPlayingList;
                        // Navigator.push(context, MaterialPageRoute(builder: (_) {
                        //   return MovieListScreenWeb(
                        //     movieList: movieList,
                        //     isMobileWeb: widget.isMobileWeb,
                        //   );
                        // }));
                      },
                    ),
                    const SizedBox(height: 20),
                    const OnTvGridWeb(
                      limit: 5,
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
