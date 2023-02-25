import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/repo/movie/end.points.dart';

class Movie {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  List<int> genreIdListJson;
  double voteAverage;
  List<MovieGenre>? genreIdList;
  Movie({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdListJson,
    required this.voteAverage,
    this.genreIdList,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      backdropPath: kImageBaseUrl + (json['backdrop_path'] ?? ""),
      posterPath: kImageBaseUrl + (json['poster_path'] ?? ""),
      genreIdListJson:
          (json['genre_ids'] as List).map((e) => e as int).toList(),
      title: json['title'] ?? "",
      // voteAverage: 0.0,
      voteAverage: json['vote_average'],
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'backdrop_path': backdropPath});
    result.addAll({'poster_path': posterPath});
    result.addAll({'title': title});
    result.addAll({'vote_average': voteAverage});

    return result;
  }

  
}
