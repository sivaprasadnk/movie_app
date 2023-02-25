import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/repo/movie/end.points.dart';

class MovieDetails {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  List<MovieGenre> genreList;
  double voteAverage;
  int voteCount;
  List<MovieGenre>? genreIdList;
  int runtime;
  String releaseDate;
  String overview;
  MovieDetails({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreList,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.releaseDate,
    required this.overview,
    this.genreIdList,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      genreList:
          (json['genres'] as List).map((e) => MovieGenre.fromJson(e)).toList(),
      title: json['title'] ?? "",
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      runtime: json['runtime'],
      releaseDate: json['release_date'],
      overview: json['overview'],
    );
  }
}
