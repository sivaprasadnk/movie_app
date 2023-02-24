import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/repo/end.points.dart';

class Movie {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  // double popularity;
  List<int> genreIdListJson;
  double voteAverage;
  List<MovieGenre>? genreIdList;
  Movie({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    // required this.popularity,
    required this.genreIdListJson,
    required this.voteAverage,
    this.genreIdList,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      // popularity: json['popularity'] ?? "",
      genreIdListJson:
          (json['genre_ids'] as List).map((e) => e as int).toList(),
      title: json['title'] ?? "",
      voteAverage: 0.0,
      // voteAverage: json['vote_average'],
    );
  }
}
