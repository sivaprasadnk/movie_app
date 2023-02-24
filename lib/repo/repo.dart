import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/repo/end.points.dart';

class Repo {
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
      debugPrint(response.body);
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
      debugPrint(response.body);
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
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        var movieList = item['results'] as List;
        if (movieList.isNotEmpty) {
          for (var i in movieList) {
            if (finalList.length < 5) {
              finalList.add(TvShows.fromJson(i));
            }
          }
        }
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return finalList;
  }
}
