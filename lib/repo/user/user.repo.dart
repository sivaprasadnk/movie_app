import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/utils/string.constants.dart';

var userColllection = FirebaseFirestore.instance.collection(kUsersCollection);

class UserRepo {
  static Future addUserDetails() async {
    var user = FirebaseAuth.instance.currentUser!;

    userColllection.doc(user.uid).set({
      kEmail: user.email,
      kDisplayName: user.displayName,
      kBookMarkedMovieIdList: [],
      kCreatedDateTime: DateTime.now(),
    });
  }

  static Future addMovieToBookmarks(MovieDetails movie) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    userColllection
        .doc(userId)
        .collection(kMoviesCollection)
        .add(movie.toMap());

    List list = await getBookmarkMovieIds();

    list.add(movie.id);

    userColllection.doc(userId).update({
      kBookMarkedMovieIdList: list,
    });
  }

  static Future addTvShowToBookmarks(TvShows show) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    userColllection
        .doc(userId)
        .collection(kTvShowsCollection)
        .add(show.toMap());
    var list = await getBookmarkMovieIds();
    userColllection.doc(userId).update({
      // kBooksMarkCount: list.length + 1,
    });
  }

  static Future<List<int>> getBookmarkMovieIds() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    var docSnapshot = await userColllection.doc(userId).get();
    var list = docSnapshot[kBookMarkedMovieIdList] as List;
    return list.isEmpty ? [] : list.map((e) => e as int).toList();
  }

  static Future<List<MovieDetails>> getBookmarkedMovies() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    List<MovieDetails> list = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> list1 =
        (await userColllection.doc(userId).collection(kMoviesCollection).get())
            .docs;
    for (var i in list1) {
      list.add(MovieDetails.fromDoc(i));
    }
    return list;
  }
}
