import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/repo/end.points.dart';

class TvShows {
  String name;
  int id;
  String backdropPath;
  String posterPath;
  // double popularity;
  List<int> genreIdListJson;
  double voteAverage;
  List<MovieGenre>? genreIdList;
  TvShows({
    required this.name,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    // required this.popularity,
    required this.genreIdListJson,
    required this.voteAverage,
    this.genreIdList,
  });

  factory TvShows.fromJson(Map<String, dynamic> json) {
    return TvShows(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      // popularity: json['popularity'] ?? "",
      genreIdListJson:
          (json['genre_ids'] as List).map((e) => e as int).toList(),
      name: json['name'] ?? "",
      voteAverage: 0.0,
      // voteAverage: json['vote_average'],
    );
  }
}
