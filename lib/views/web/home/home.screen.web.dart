import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/web/home/widgets/now.playing.list.web.dart';
import 'package:movie_app/views/web/home/widgets/ontv.grid.web.dart';
import 'package:movie_app/views/web/home/widgets/trending.movie.carousal.web.dart';
import 'package:movie_app/views/web/movie.list/tv.show.list.screen.web.dart';
import 'package:provider/provider.dart';

import '../../../provider/movies.provider.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitleAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const TrendingMovieCarousalWeb(),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                left: context.width * 0.1,
              ),
              child: Consumer<MoviesProvider>(builder: (_, provider, __) {
                var selected = provider.selectedContentType;
                return Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider.updateContentType(Content.movie);
                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                              color: selected == Content.movie
                                  ? context.theme.primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: context.theme.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Movie',
                                style: TextStyle(
                                  color: selected != Content.movie
                                      ? context.theme.primaryColor
                                      : Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            provider.updateContentType(Content.tvShow);
                          },
                          child: Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                              color: selected == Content.tvShow
                                  ? context.theme.primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: context.theme.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Tv Show',
                                style: TextStyle(
                                  color: selected != Content.tvShow
                                      ? context.theme.primaryColor
                                      : Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (selected == Content.movie)
                      SectionTitle(
                        title: 'Now Playing',
                        withSeeMore: true,
                        seeMoreCallBack: () {
                          context.moviesProvider.updateGenre(
                            MovieGenre(id: 0, name: 'All'),
                            true,
                          );

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
                    if (selected == Content.movie)
                      const NowPlayingListWeb(
                        limit: 5,
                        isGrid: true,
                      ),
                    if (selected == Content.movie) const SizedBox(height: 20),
                    if (selected == Content.movie)
                      SectionTitle(
                        title: 'Popular Movies',
                        withSeeMore: true,
                        seeMoreCallBack: () {
                          context.moviesProvider.updateGenre(
                            MovieGenre(id: 0, name: 'All'),
                            true,
                            true,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return MovieListScreenWeb(
                                  isMobileWeb: widget.isMobileWeb,
                                  isPopularMovies: true,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    if (selected == Content.movie) const SizedBox(height: 20),
                    if (selected == Content.movie)
                      const NowPlayingListWeb(
                        limit: 5,
                        isGrid: true,
                        isPopularMovies: true,
                      ),
                    if (selected == Content.tvShow)
                      SectionTitle(
                        title: 'Top Rated',
                        withSeeMore: true,
                        seeMoreCallBack: () {
                          context.moviesProvider.updateGenre(
                            MovieGenre(id: 0, name: 'All'),
                            false,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return TvShowListScreenWeb(
                                  isMobileWeb: widget.isMobileWeb,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    if (selected == Content.tvShow) const SizedBox(height: 20),
                    if (selected == Content.tvShow)
                      const TvShowGridWeb(
                        limit: 5,
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
