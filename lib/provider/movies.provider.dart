import 'package:flutter/material.dart';
import 'package:movie_app/model/actors.model.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/repo/movie/movie.repo.dart';

class MoviesProvider extends ChangeNotifier {
  MovieDetails? _selectedMovie;
  MovieDetails? get selectedMovie => _selectedMovie;

  void updateSelectedMovie(MovieDetails movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

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

  List<Movie> _similarMovieList = [];
  List<Movie> get similarMovieList => _similarMovieList;

  List<Movie> _nowPlayingList = [];
  List<Movie> get nowPlayingList => _nowPlayingList;

  List<TvShows> _onTvList = [];
  List<TvShows> get onTvList => _onTvList;

  List<Actors> _actorsList = [];
  List<Actors> get actorsList => _actorsList;

  final List<Movie> _carousalMovieList = [];
  List<Movie> get carousalMovieList => _carousalMovieList;

  void updateMovieGenreList(List<MovieGenre> list) {
    _movieGenreList = list;
    notifyListeners();
  }

  bool _trendingListLoading = true;
  bool get trendingListLoading => _trendingListLoading;

  bool _actorsListLoading = true;
  bool get actorsListLoading => _actorsListLoading;

  bool _nowPlayingListLoading = true;
  bool get nowPlayingListLoading => _nowPlayingListLoading;

  bool _onTVListLoading = true;
  bool get onTVListLoading => _onTVListLoading;

  bool _similarMovieListLoading = true;
  bool get similarMovieListLoading => _similarMovieListLoading;

  void updateTrendingListLoading(bool value) {
    _trendingListLoading = value;
    notifyListeners();
  }

  void updateActorsListLoading(bool value) {
    _actorsListLoading = value;
    notifyListeners();
  }

  Future getTrendingList() async {
    _trendingListLoading = true;
    _trendingMovieList = [];
    _trendingMovieList = await MovieRepo.getTrendingList();
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
    _nowPlayingList = [];
    _nowPlayingList = await MovieRepo.getNowPlayingList();

    _nowPlayingListLoading = false;
    notifyListeners();
  }

  Future getOnTvList() async {
    _onTVListLoading = true;
    _onTvList = [];
    _onTvList = await MovieRepo.getOnTvList();

    _onTVListLoading = false;
    notifyListeners();
  }

  Future getGenres() async {
    _movieGenreList = await MovieRepo.getGenreList();
    notifyListeners();
  }

  Future getDetails(int id) async {
    _selectedMovie = await MovieRepo.getMovieDetails(id);
    getActorsList(id);
    getSimilarMoviesList(id);
    notifyListeners();
  }

  Future getActorsList(int id) async {
    _actorsListLoading = true;
    _actorsList = [];
    _actorsList = await MovieRepo.getActorsList(id);

    _actorsListLoading = false;
    notifyListeners();
  }

  Future getSimilarMoviesList(int id) async {
    _similarMovieListLoading = true;
    _similarMovieList = [];
    _similarMovieList = await MovieRepo.getSimilarMoviesList(id);

    _similarMovieListLoading = false;
    notifyListeners();
  }
}
