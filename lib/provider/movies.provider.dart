import 'package:flutter/material.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/repo/repo.dart';

class MoviesProvider extends ChangeNotifier {
  int _carousalIndex = 0;
  int get carousalIndex => _carousalIndex;

  void updateCarousalIndex(int index) {
    _carousalIndex = index;
    notifyListeners();
  }

  List<MovieGenre> _movieGenreList = [];
  List<MovieGenre> get movieGenreList => _movieGenreList;

  List<Movie> _trendingMovieList = [];
  List<Movie> get trendingMovieList => _trendingMovieList;

  List<Movie> _nowPlayingList = [];
  List<Movie> get nowPlayingList => _nowPlayingList;

  List<TvShows> _onTvList = [];
  List<TvShows> get onTvList => _onTvList;

  final List<Movie> _carousalMovieList = [];
  List<Movie> get carousalMovieList => _carousalMovieList;

  void updateMovieGenreList(List<MovieGenre> list) {
    _movieGenreList = list;
    notifyListeners();
  }

  bool _trendingListLoading = true;
  bool get trendingListLoading => _trendingListLoading;

  bool _nowPlayingListLoading = true;
  bool get nowPlayingListLoading => _nowPlayingListLoading;

  bool _onTVListLoading = true;
  bool get onTVListLoading => _onTVListLoading;

  void updateTrendingListLoading(bool value) {
    _trendingListLoading = value;
    notifyListeners();
  }

  Future getTrendingList() async {
    _trendingListLoading = true;
    _trendingMovieList = await Repo.getTrendingList();
    for (var i in _trendingMovieList) {
      if (_carousalMovieList.length < 5) {
        _carousalMovieList.add(i);
      }
    }
    _trendingListLoading = false;
    notifyListeners();
  }

  Future getNowPlayingList() async {
    _nowPlayingListLoading = true;
    _nowPlayingList = await Repo.getNowPlayingList();

    _nowPlayingListLoading = false;
    notifyListeners();
  }

  Future getOnTvList() async {
    _onTVListLoading = true;
    _onTvList = await Repo.getOnTvList();

    _onTVListLoading = false;
    notifyListeners();
  }

  Future getGenres() async {
    _movieGenreList = await Repo.getGenreList();
    notifyListeners();
  }
}
