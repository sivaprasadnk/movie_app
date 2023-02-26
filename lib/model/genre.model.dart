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
}
