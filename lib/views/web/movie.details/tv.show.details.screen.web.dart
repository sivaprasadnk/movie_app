import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/provider/auth.provider.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/common.button.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/actors.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/similar.shows.list.dart';
import 'package:provider/provider.dart';

class TvShowDetailsScreenWeb extends StatefulWidget {
  const TvShowDetailsScreenWeb({super.key});
  static const routeName = "/tvshow/";
  @override
  State<TvShowDetailsScreenWeb> createState() => _TvShowDetailsScreenWebState();
}

class _TvShowDetailsScreenWebState extends State<TvShowDetailsScreenWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<MoviesProvider>(
          builder: (_, provider, __) {
            var show = provider.selectedShow!;
            var year = show.releaseDate.split('-').first;
            var cacheKey = "tvshow_${show.id}${show.name}";
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomCacheImage(
                      imageUrl: show.backdropPath,
                      height: context.height * 0.4,
                      width: double.infinity,
                      cacheKey: cacheKey,
                      borderRadius: 0,
                    ),
                    Positioned.fill(
                      top: 50,
                      left: 20,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 250.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                Colors.white,
                                Colors.transparent,
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 60,
                      left: 20,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          show.name,
                          maxLines: 3,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 30,
                      left: 20,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text(
                              year,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              show.genreList.stringText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Text(
                            //   show.runtime.durationInHrs,
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: 12,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 10,
                      left: 20,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              show.voteAverage.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "( ${show.voteCount} )",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const SectionTitle(title: 'Story'),
                      const SizedBox(height: 20),
                      Text(show.overview),
                      const SizedBox(height: 20),
                      if (!provider.actorsListLoading)
                        if (provider.actorsList.isNotEmpty)
                          const SectionTitle(title: 'Cast'),
                      const SizedBox(height: 20),
                      AnimatedSwitcher(
                        duration: const Duration(
                          seconds: 1,
                        ),
                        child: !provider.actorsListLoading
                            ? const ActorsList()
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 20),
                      if (!provider.actorsListLoading)
                        if (provider.similarTvShowList.isNotEmpty)
                          const SectionTitle(title: 'Similar'),
                      const SizedBox(height: 20),
                      if (!provider.actorsListLoading) const SimilarShowsList(),
                      const SizedBox(height: 20),
                      if (!provider.actorsListLoading &&
                          !provider.similarTvShowsLoading)
                        Consumer<AuthProvider>(builder: (_, authProvider, __) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: CommonButton(
                                callback: () {
                                  if (!authProvider.isGuestUser) {
                                    context.userProvider
                                        .addTvShowToBookmarks(show, context);
                                  } else {
                                    context.scaffoldMessenger.showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Login to Bookmark !")));
                                  }
                                },
                                title: 'Bookmark '),
                          );
                        }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
