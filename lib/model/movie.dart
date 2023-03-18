import 'package:movie_app/repo/movie/end.points.dart';

enum MovieType { trending, nowPlaying, topRated, upcoming, similar }

class Movie {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  List<int> genreIdList;
  double voteAverage;
  MovieType movieType;
  Movie({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.posterPath,
    required this.genreIdList,
    required this.voteAverage,
    required this.movieType,
  });

  factory Movie.fromJson(Map<String, dynamic> json, MovieType type) {
    var vote = json['vote_average'];
    if (vote.runtimeType == int) {
      vote = (vote as int).toDouble();
    }
    return Movie(
      id: json['id'],
      backdropPath: kOriginalImageBaseUrl + (json['backdrop_path'] ?? ""),
      posterPath: kImageBaseUrl + (json['poster_path'] ?? ""),
      genreIdList: (json['genre_ids'] as List).map((e) => e as int).toList(),
      title: json['title'] ?? "",
      voteAverage: vote,
      movieType: type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'backdrop_path': backdropPath});
    result.addAll({'poster_path': posterPath});
    result.addAll({'title': title});
    result.addAll({'vote_average': voteAverage});
    result.addAll({'movie_type': movieType});

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

  List<Movie> trendingMovies(int limit) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.trending) {
        if (list.length < limit) {
          list.add(movie);
        }
      }
    }
    return list;
  }

  List<Movie> nowPlayingMovies(int limit) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.nowPlaying) {
        list.add(movie);
        // if (list.length < limit) {
        // }
      }
    }
    return list;
  }

  List<Movie> popularMovies(int limit) {
    List<Movie> list = [];
    for (var movie in this) {
      if (movie.movieType == MovieType.topRated) {
        list.add(movie);
        // if (list.length < limit) {
        // }
      }
    }
    return list;
  }
}
