import 'package:flutter/material.dart';
import 'package:movie_app/provider/user.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/page.title.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/home/page/movie.list/widgets/movie.card.dart';
import 'package:movie_app/views/home/page/profile/widgets/empty.bookmark.list.container.dart';
import 'package:provider/provider.dart';

import '../../../../utils/dialogs.dart';

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
      await context.userProvider.getBookmarkedMovies(context).then((value) {
        context.pop();
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
            return Column(
              children: [
                const PageTitle(
                  title: 'Bookmark List',
                  showLeadingIcon: true,
                ),
                if (!provider.bookmarkListLoading)
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
                          const SectionTitle(title: 'Movies'),
                          const SizedBox(height: 20),
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
