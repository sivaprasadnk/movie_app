import 'package:flutter/material.dart';
import 'package:movie_app/provider/user.provider.dart';
import 'package:movie_app/utils/dialogs.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/movie.card.dart';
import 'package:movie_app/views/common/page.title.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/profile/widgets/empty.bookmark.list.container.dart';
import 'package:provider/provider.dart';

class BookmarkListScreen extends StatefulWidget {
  const BookmarkListScreen({super.key});

  static const routeName = "/bookmarks";

  @override
  State<BookmarkListScreen> createState() => _BookmarkListScreenState();
}

class _BookmarkListScreenState extends State<BookmarkListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Dialogs.showLoader(context: context);
      await context.userProvider
          .getBookmarkedMovies(context)
          .then((value) async {
        await context.userProvider.getBookmarkedShows(context).then((value) {
          context.pop();
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<UserProvider>(builder: (_, provider, __) {
            var moviesList = provider.bookMarkMoviesList;
            var shows = provider.bookMarkShowsList;
            return Column(
              children: [
                const PageTitle(
                  title: 'Bookmark List',
                  showLeadingIcon: true,
                ),
                if (!provider.bookmarkListLoading &&
                    !provider.bookmarkShowsListLoading)
                  if (moviesList.isEmpty)
                    const Center(
                      child: EmptyBookmarkListContainer(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 30),
                          if (!provider.bookmarkListLoading)
                            const SectionTitle(title: 'Movies'),
                          const SizedBox(height: 20),
                          if (!provider.bookmarkListLoading)
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 15);
                                },
                                shrinkWrap: true,
                                itemCount: moviesList.length,
                                itemBuilder: (context, index) {
                                  var movie = moviesList[index];
                                  return MovieCard(
                                    poster: movie.posterPath,
                                    name: movie.title,
                                    vote: movie.voteAverage,
                                    id: movie.id,
                                    withSize: false,
                                    releaseDate: movie.releaseDate,
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 30),
                          if (!provider.bookmarkShowsListLoading)
                            if (shows.isNotEmpty)
                              const SectionTitle(title: 'Tv Shows'),
                          const SizedBox(height: 20),
                          if (!provider.bookmarkShowsListLoading)
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 15);
                                },
                                shrinkWrap: true,
                                itemCount: shows.length,
                                itemBuilder: (context, index) {
                                  var movie = shows[index];
                                  return MovieCard(
                                    poster: movie.posterPath,
                                    name: movie.name,
                                    vote: movie.voteAverage,
                                    id: movie.id,
                                    isMovie: false,
                                    withSize: false,
                                    releaseDate: movie.releaseDate,
                                  );
                                },
                              ),
                            )
                        ],
                      ),
                    )
              ],
            );
          }),
        ),
      ),
    );
  }
}
