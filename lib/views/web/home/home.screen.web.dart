import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/content.selection.dart';
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

      context.moviesProvider.getMovieGenres();
      context.moviesProvider.getTVGenres();
      context.moviesProvider.getMoviesList();
      context.moviesProvider.getTvShowsList();
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
                    ContentSelection(provider: provider, selected: selected),
                    const SizedBox(height: 20),
                    if (selected == Content.movie)
                      SectionTitle(
                        title: 'Now Playing',
                        withSeeMore: true,
                        seeMoreCallBack: () {
                          context.moviesProvider.updateMovieGenre(
                            Genre(id: 0, name: 'All'),
                            MovieType.nowPlaying,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return MovieListScreenWeb(
                                  isMobileWeb: widget.isMobileWeb,
                                  title: 'Now Playing',
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
                          context.moviesProvider.updateMovieGenre(
                            Genre(id: 0, name: 'All'),
                            MovieType.topRated,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return MovieListScreenWeb(
                                  isMobileWeb: widget.isMobileWeb,
                                  movieType: MovieType.topRated,
                                  title: 'Popular Movies',
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
                        type: MovieType.topRated,
                      ),
                    if (selected == Content.tvShow)
                      SectionTitle(
                        title: 'Top Rated',
                        withSeeMore: true,
                        seeMoreCallBack: () {
                          context.moviesProvider.updateTvShowGenre(
                            Genre(id: 0, name: 'All'),
                            TvShowType.topRated,
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
