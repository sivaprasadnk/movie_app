import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/int.extensions.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:movie_app/views/common/loading.shimmer.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/web/home/widgets/actors.list.web.dart';
import 'package:movie_app/views/web/home/widgets/movie.grid.dart';
import 'package:movie_app/views/web/home/widgets/video.list.web.dart';
import 'package:provider/provider.dart';

class MovieDetailsLarge extends StatelessWidget {
  const MovieDetailsLarge({super.key, required this.movie});

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) {
    var cacheKey = 'movie_${movie.id}details';
    var cacheKey1 = 'movie_${movie.id}poster';

    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: const Color.fromRGBO(26, 26, 26, 1),
              height: context.height * 0.6,
              width: double.infinity,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Stack(
                  children: [
                    SizedBox(
                      width: context.width > 800
                          ? context.width * 0.6
                          : double.infinity,
                      child: CustomCacheImage(
                        imageUrl: movie.backdropPath,
                        height: context.height * 0.6,
                        width: double.infinity,
                        cacheKey: cacheKey,
                        borderRadius: 0,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: context.height * 0.6,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(26, 26, 26, 1),
                            gradient: LinearGradient(
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                              colors: [
                                Color.fromRGBO(26, 26, 26, 1),
                                Colors.transparent,
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned.fill(
              left: context.width * 0.1,
              top: 20,
              bottom: 20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                  future: _getImageSize(movie.posterPath),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      double aspectRatio =
                          snapshot.data!.width / snapshot.data!.height;
                      debugPrint('height : ${snapshot.data!.height}');
                      debugPrint('width : ${snapshot.data!.width}');
                      return AspectRatio(
                        aspectRatio: aspectRatio,
                        child: CustomCacheImageWithoutSize(
                          imageUrl: movie.posterPath,
                          borderRadius: 10,
                          cacheKey: cacheKey1,
                        ),
                      );
                    } else {
                      return LoadingShimmer(
                        child: AspectRatio(
                          aspectRatio: 0.667,
                          child: Container(
                            width: 500,
                            height: 750,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned.fill(
              left: context.width * 0.1 + 350,
              top: 50,
              bottom: 20,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.red.shade500,
                          size: 40,
                        ),
                        const SizedBox(width: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${movie.voteAverage}/ 10",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${movie.voteCount} votes",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movie.genreList.stringText,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          movie.runtime.durationInHrs,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
          child: Consumer<MoviesProvider>(builder: (_, provider, __) {
            return Column(
              children: [
                const SizedBox(height: 15),
                const SectionTitle(title: 'Story'),
                const SizedBox(height: 20),
                Text(movie.overview),
                const SizedBox(height: 40),
                if (!provider.videosLoading)
                  if (provider.videoList.isNotEmpty)
                    const SectionTitle(title: 'Related Videos'),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(
                    seconds: 1,
                  ),
                  child: !provider.videosLoading
                      ? const VideoListWeb()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 40),
                if (!provider.actorsListLoading)
                  if (provider.actorsList.isNotEmpty)
                    const SectionTitle(title: 'Cast'),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(
                    seconds: 1,
                  ),
                  child: !provider.actorsListLoading
                      ? const ActorsListWeb()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 40),
                if (!provider.actorsListLoading)
                  if (provider.similarMovieList.isNotEmpty)
                    const SectionTitle(
                      title: 'Similar',
                    ),
                const SizedBox(height: 20),
                if (!provider.actorsListLoading)
                  if (provider.similarMovieList.isNotEmpty)
                    MovieGrid(
                      isLoading: provider.similarMovieListLoading,
                      movieGrid: provider.similarMovieList,
                      isWeb: true,
                      limit: context.gridCrossAxisCount,
                    ),
              ],
            );
          }),
        ),
      ],
    );
  }

  Future<Size> _getImageSize(String imageUrl) {
    Completer<Size> completer = Completer();
    NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo info, bool _) {
          completer.complete(
              Size(info.image.width.toDouble(), info.image.height.toDouble()));
        },
      ),
    );
    return completer.future;
  }
}
