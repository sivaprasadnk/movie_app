import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/provider/auth.provider.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/int.extensions.dart';
import 'package:movie_app/views/common/actors.list.dart';
import 'package:movie_app/views/common/common.button.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/common/social.media.links.dart';
import 'package:movie_app/views/common/video.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/back.button.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/backdrop.image.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/bg.gradient.container.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/movie/widgets/movie.rating.dart';
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
    return WillPopScope(
      onWillPop: () async {
        context.moviesProvider.updateCarousalIndex(0);
        context.moviesProvider.updateDataStatus(false);
        context.goHome();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
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
                        BackdropImageMobile(movie: movie),
                        const BgBradientContainerMobile(),
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
                        MovieRatingDetailsMobile(movie: movie),
                        const BackButtonMobile(),
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
                                ? const ActorsList(
                                    size: 120,
                                    height: 190,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 20),
                          Consumer<MoviesProvider>(
                            builder: (_, provider, __) {
                              var social = provider.socialMediaModel;
                              return social.isLoading
                                  ? const SizedBox.shrink()
                                  : Column(
                                      children: [
                                        const SectionTitle(title: 'Follow on '),
                                        const SizedBox(height: 20),
                                        SocialMediaLinks(
                                          model: social,
                                          isMobile: true,
                                        ),
                                      ],
                                    );
                            },
                          ),
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
                                ? const VideoList()
                                : const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 20),
                          if (!provider.actorsListLoading)
                            if (provider.similarMovieList.isNotEmpty)
                              const SectionTitle(title: 'Similar'),
                          const SizedBox(height: 20),
                          if (!provider.actorsListLoading)
                            const SimilarMovieList(),
                          const SizedBox(height: 20),
                          if (!provider.actorsListLoading &&
                              !provider.similarMovieListLoading)
                            Consumer<AuthProvider>(
                                builder: (_, authProvider, __) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: CommonButton(
                                    callback: () {
                                      if (!authProvider.isGuestUser) {
                                        context.userProvider
                                            .addMovieToBookmarks(
                                                movie, context);
                                      } else {
                                        context.scaffoldMessenger.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "Login to Bookmark !")));
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
        ),
      ),
    );
  }
}
