import 'package:movie_app/model/movie.dart';

class MovieGenre {
  int id;
  String name;
  MovieGenre({
    required this.id,
    required this.name,
  });

  factory MovieGenre.fromJson(Map<String, dynamic> json) {
    return MovieGenre(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }
}

extension GenreExt on List<MovieGenre> {
  String get stringText {
    String list = " [ ";
    var count = 0;
    var limit = length > 3 ? 3 : length;
    for (var i in this) {
      if (count < limit) {
        list += i.name;

        if (count != limit - 1) {
          list += ", ";
        }
        count++;
      }
    }
    list = "$list ]";
    return list;
  }

  List<MovieGenre> movieGenres(List<Movie> movieList) {
    var list = <MovieGenre>[];
    var idList = <int>[];

    idList = movieList.uniqueIdList();
    list.add(MovieGenre(id: 0, name: 'All'));
    for (var i in this) {
      for (var id in idList) {
        if (id == i.id) {
          list.add(MovieGenre(id: id, name: i.name));
        }
      }
    }

    return list;
  }
}

extension GenreExts on MovieGenre {
  List<Movie> getFilteredList(List<Movie> movieList) {
    var list = <Movie>[];

    for (var movie in movieList) {
      if (movie.genreIdList.contains(id)) {
        list.add(movie);
      }
    }

    return list;
  }
}
