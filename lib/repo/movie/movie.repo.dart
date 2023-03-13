import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/actors.model.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/model/related.video.model.dart';
import 'package:movie_app/model/tv.show.details.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/repo/movie/api.key.dart';
import 'package:movie_app/repo/movie/end.points.dart';

class MovieRepo {
  static Future<List<MovieGenre>> getGenreList() async {
    List<MovieGenre> list = [];
    try {
      debugPrint(kGenreUrl);

      final response = await http.get(
        Uri.parse(kGenreUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var genreList = item['genres'] as List;
        if (genreList.isNotEmpty) {
          for (var i in genreList) {
            // list.add(MovieGenre(id: id, name: name))
            list.add(MovieGenre.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return list;
  }

  static Future getTrendingList() async {
    List<Movie> trendingList = [];
    try {
      debugPrint(kMoviesUrl);

      final response = await http.get(
        Uri.parse(kMoviesUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            trendingList.add(Movie.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return trendingList;
  }

  static Future getPopularList() async {
    List<Movie> movieList = [];
    try {
      debugPrint(kPopularMoviesUrl);

      final response = await http.get(
        Uri.parse(kPopularMoviesUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var list = item['results'] as List;
        if (list.isNotEmpty) {
          for (var i in list) {
            movieList.add(Movie.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return movieList;
  }

  static Future getNowPlayingList() async {
    List<Movie> finalList = [];
    try {
      debugPrint(kPlayingNowUrl);

      final response = await http.get(
        Uri.parse(kPlayingNowUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            finalList.add(Movie.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return finalList;
  }

  static Future getOnTvList() async {
    List<TvShows> finalList = [];
    try {
      debugPrint(kTvShowsUrl);

      final response = await http.get(
        Uri.parse(kTvShowsUrl),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            finalList.add(TvShows.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return finalList;
  }

  static Future<MovieDetails?> getMovieDetails(int id) async {
    MovieDetails? movie;
    try {
      var url = "${kBaseUrl}movie/$id?api_key=$apiKey";
      debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);r
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        movie = MovieDetails.fromJson(item);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return movie;
  }

  static Future<TvShowDetails?> getTvShowDetails(int id) async {
    TvShowDetails? show;
    try {
      var url = "${kBaseUrl}tv/$id?api_key=$apiKey";
      debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        show = TvShowDetails.fromJson(item);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return show;
  }

  static Future<List<Actors>> getActorsList(int id) async {
    List<Actors> actorsList = [];

    try {
      var url = "${kBaseUrl}movie/$id/credits?api_key=$apiKey";
      debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var castList = item['cast'] as List;
        if (castList.isNotEmpty) {
          for (var i in castList) {
            actorsList.add(Actors.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return actorsList;
  }

  static Future getSimilarMoviesList(int id) async {
    List<Movie> finalList = [];
    try {
      var url = "${kBaseUrl}movie/$id/similar?api_key=$apiKey";
      debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            finalList.add(Movie.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return finalList;
  }

  static Future getSimilarTvShowList(int id) async {
    List<TvShows> finalList = [];
    try {
      var url = "${kBaseUrl}tv/$id/similar?api_key=$apiKey";
      debugPrint(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            finalList.add(TvShows.fromJson(i));
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return finalList;
  }

  static Future<List<RelatedVideoModel>> getRelatedVideos(int movieId) async {
    List<RelatedVideoModel> videoList = [];
    var url = "${kBaseUrl}movie/$movieId/videos?api_key=$apiKey";
    debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      var videos = item['results'] as List;
      if (videos.isNotEmpty) {
        for (var i in videos) {
          videoList.add(RelatedVideoModel.fromJson(i));
        }
      }
    }

    return videoList;
  }
}
