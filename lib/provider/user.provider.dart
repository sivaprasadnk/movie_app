import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/repo/user/user.repo.dart';

class UserProvider extends ChangeNotifier {

  //

  Future<List<int>> getBookmarksCount() async {
    var user = FirebaseAuth.instance.currentUser!;
    return await UserRepo.getBookmarkMovieIds(user.uid);
  }

  Future<int> addMovieToBookmarks(MovieDetails movie) async {
    return await UserRepo.addMovieToBookmarks(movie);
  }
}
