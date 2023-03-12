import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/provider/auth.provider.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/time.extensions.dart';
import 'package:movie_app/views/common/common.button.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/actors.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/similar.movies.list.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});
  static const routeName = "/MovieDetails";
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<MoviesProvider>(
          builder: (_, provider, __) {
            var movie = provider.selectedMovie!;
            var year = movie.releaseDate.split('-').first;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        movie.backdropPath,
                        height: context.height * 0.4,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
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
                          movie.title,
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
                              movie.genreList.stringText,
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
                              movie.runtime.durationInHrs,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
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
                              movie.voteAverage.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "( ${movie.voteCount} )",
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
                      Text(movie.overview),
                      const SizedBox(height: 20),
                      if (!provider.actorsListLoading)
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
                        if (provider.similarMovieList.isNotEmpty)
                          const SectionTitle(title: 'Similar'),
                      const SizedBox(height: 20),
                      if (!provider.actorsListLoading) const SimilarMovieList(),
                      const SizedBox(height: 20),
                      if (!provider.actorsListLoading &&
                          !provider.similarMovieListLoading)
                        Consumer<AuthProvider>(builder: (_, authProvider, __) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: CommonButton(
                                callback: () {
                                  if (!authProvider.isGuestUser) {
                                    context.userProvider
                                        .addMovieToBookmarks(movie, context);
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
