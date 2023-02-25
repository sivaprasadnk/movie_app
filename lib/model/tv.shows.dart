import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/repo/movie/end.points.dart';

class TvShows {
  String name;
  int id;
  String backdropPath;
  String posterPath;
  List<int> genreIdListJson;
  double voteAverage;
  List<MovieGenre>? genreIdList;
  TvShows({
    required this.name,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdListJson,
    required this.voteAverage,
    this.genreIdList,
  });

  factory TvShows.fromJson(Map<String, dynamic> json) {
    return TvShows(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      genreIdListJson:
          (json['genre_ids'] as List).map((e) => e as int).toList(),
      name: json['name'] ?? "",
      voteAverage: 0.0,
      // voteAverage: json['vote_average'],
    );
  }
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'backdrop_path': backdropPath});
    result.addAll({'poster_path': posterPath});
    result.addAll({'name': name});
    result.addAll({'vote_average': voteAverage});

    return result;
  }
}
