import 'package:movie_app/repo/movie/end.points.dart';

class TvShows {
  String name;
  int id;
  String backdropPath;
  String posterPath;
  List<int> genreIdList;
  double voteAverage;
  TvShows({
    required this.name,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdList,
    required this.voteAverage,
  });

  factory TvShows.fromJson(Map<String, dynamic> json) {
    return TvShows(
      id: json['id'],
      backdropPath: kImageBaseUrl + json['backdrop_path'],
      posterPath: kImageBaseUrl + json['poster_path'],
      genreIdList:
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


extension TvShowExtension on List<TvShows> {
  List<TvShows> homeScreenList(int limit) {
    List<TvShows> list = [];
    for (var show in this) {
      if (list.length < limit) {
        list.add(show);
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
