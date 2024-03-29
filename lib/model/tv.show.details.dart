import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/repo/movie/end.points.dart';

class TvShowDetails {
  String name;
  int id;
  String backdropPath;
  String posterPath;
  List<Genre> genreList;
  double voteAverage;
  int voteCount;
  // int runtime;
  String releaseDate;
  String overview;
  TvShowDetails({
    required this.name,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreList,
    required this.voteAverage,
    required this.voteCount,
    // required this.runtime,
    required this.releaseDate,
    required this.overview,
  });

  factory TvShowDetails.fromJson(Map<String, dynamic> json) {
    return TvShowDetails(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      genreList:
          (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      name: json['name'] ?? "",
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      // runtime: json['runtime'],
      releaseDate: json['first_air_date'],
      overview: json['overview'],
    );
  }

  factory TvShowDetails.fromDoc(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    var name = "";
    if (!json.data().containsKey('name')) {
      name = json['title'];
    } else {
      name = json['name'];
    }
    return TvShowDetails(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      genreList:
          (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      name: name,
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      releaseDate: json['first_air_date'],
      overview: json['overview'],
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    var genreMapList = genreList.map((e) => e.toJson()).toList();
    result.addAll({'genres': genreMapList});
    result.addAll({'backdrop_path': backdropPath});
    result.addAll({'poster_path': posterPath});
    result.addAll({'name': name});
    result.addAll({'vote_average': voteAverage});
    result.addAll({'vote_count': voteCount});
    // result.addAll({'runtime': runtime});
    result.addAll({'overview': overview});
    result.addAll({'first_air_date': releaseDate});

    return result;
  }
}
