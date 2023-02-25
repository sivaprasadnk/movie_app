import 'package:movie_app/repo/movie/end.points.dart';

class Actors {
  int id;
  String name;
  String profilePath;
  int order;
  Actors({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.order,
  });
  factory Actors.fromJson(Map<String, dynamic> json) {
    return Actors(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      order: json['order'] ?? 0,
      profilePath: kImageBaseUrl + (json['profile_path'] ?? ""),
    );
  }
}
