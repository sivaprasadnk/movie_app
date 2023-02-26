import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/repo/user/user.repo.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/home/home.screen.dart';

class UserProvider extends ChangeNotifier {
  //

  List<MovieDetails> _bookMarkMoviesList = [];
  List<MovieDetails> get bookMarkMoviesList => _bookMarkMoviesList;

  bool _bookmarkListLoading = true;
  bool get bookmarkListLoading => _bookmarkListLoading;

  Future<List<int>> getBookmarksCount() async {
    return await UserRepo.getBookmarkMovieIds();
  }

  Future addMovieToBookmarks(MovieDetails movie, BuildContext context) async {
    var savedIds = await UserRepo.getBookmarkMovieIds();
    if (savedIds.contains(movie.id)) {
      if (context.mounted) {
        context.scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text("Already Bookmarked !")));
      }
    } else {
      await UserRepo.addMovieToBookmarks(movie);
      if (context.mounted) {
        context.scaffoldMessenger.showSnackBar(
            SnackBar(content: Text("${movie.title}  added to Bookmarks !")));
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      }
    }
  }

  void clearList() {
    _bookMarkMoviesList.clear();
    notifyListeners();
  }

  Future getBookmarkedMovies(BuildContext context) async {
    _bookmarkListLoading = true;
    _bookMarkMoviesList.clear();
    notifyListeners();
    _bookMarkMoviesList = await UserRepo.getBookmarkedMovies();

    _bookmarkListLoading = false;
    notifyListeners();
  }
}
