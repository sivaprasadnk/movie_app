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
}

// extension GenreExt on List<int>{
//   List<MovieGenre> getGenreModelList{

//   }
// }
