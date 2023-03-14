import 'package:movie_app/repo/movie/end.points.dart';

class Movie {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  List<int> genreIdList;
  double voteAverage;
  Movie({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdList,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      backdropPath: kOriginalImageBaseUrl + (json['backdrop_path'] ?? ""),
      posterPath: kImageBaseUrl + (json['poster_path'] ?? ""),
      genreIdList:
          (json['genre_ids'] as List).map((e) => e as int).toList(),
      title: json['title'] ?? "",
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

extension MovieExtension on List<Movie> {
  List<Movie> homeScreenList(int limit) {
    List<Movie> list = [];
    for (var movie in this) {
      if (list.length < limit) {
        list.add(movie);
      }
    }
    return list;
  }

  List<Movie> filteredList(int limit) {
    List<Movie> list = [];
    for (var movie in this) {
      if (list.length < limit) {
        list.add(movie);
      }
    }
    return list;
  }

  List<int> uniqueIdList() {
    List<int> idList = [];
    for (var i in this) {
      for (var id in i.genreIdList) {
        idList.add(id);
      }
    }
    return idList.toSet().toList();
  }
}
