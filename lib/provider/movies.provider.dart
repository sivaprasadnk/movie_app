import 'package:flutter/material.dart';
import 'package:movie_app/model/actors.model.dart';
import 'package:movie_app/model/genre.model.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/model/movie.details.dart';
import 'package:movie_app/model/related.video.model.dart';
import 'package:movie_app/model/tv.show.details.dart';
import 'package:movie_app/model/tv.shows.dart';
import 'package:movie_app/repo/movie/movie.repo.dart';

class MoviesProvider extends ChangeNotifier {
  MovieDetails? _selectedMovie;
  MovieDetails? get selectedMovie => _selectedMovie;

  TvShowDetails? _selectedShow;
  TvShowDetails? get selectedShow => _selectedShow;

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

  List<Movie> _popularMovieList = [];
  List<Movie> get popularMovieList => _popularMovieList;

  List<Movie> _similarMovieList = [];
  List<Movie> get similarMovieList => _similarMovieList;

  List<TvShows> _similarTvShowList = [];
  List<TvShows> get similarTvShowList => _similarTvShowList;

  List<Movie> _nowPlayingList = [];
  List<Movie> get nowPlayingList => _nowPlayingList;

  List<Movie> _filteredNowPlayingList = [];
  List<Movie> get filteredNowPlayingList => _filteredNowPlayingList;

  List<Movie> _filteredPopularMovies = [];
  List<Movie> get filteredPopularMovies => _filteredPopularMovies;

  List<TvShows> _filteredTvShowsList = [];
  List<TvShows> get filteredTvShowsList => _filteredTvShowsList;

  List<TvShows> _onTvList = [];
  List<TvShows> get onTvList => _onTvList;

  List<Actors> _actorsList = [];
  List<Actors> get actorsList => _actorsList;

  List<RelatedVideoModel> _videoList = [];
  List<RelatedVideoModel> get videoList => _videoList;

  final List<Movie> _carousalMovieList = [];
  List<Movie> get carousalMovieList => _carousalMovieList;

  void updateMovieGenreList(List<MovieGenre> list) {
    _movieGenreList = list;
    notifyListeners();
  }

  MovieGenre? _selectedGenre;
  MovieGenre get selectedGenre => _selectedGenre!;

  void updateGenre(MovieGenre genre, bool isMovie, [bool isPopular = false]) {
    _selectedGenre = genre;
    _filteredNowPlayingList = [];
    if (genre.id == 0) {
      if (isMovie) {
        if (!isPopular) {
          _filteredNowPlayingList = _nowPlayingList;
        } else {
          _filteredPopularMovies = _popularMovieList;
        }
      } else {
        _filteredTvShowsList = _onTvList;
      }
    } else {
      if (isMovie) {
        if (!isPopular) {
          _filteredNowPlayingList = genre.getFilteredList(_nowPlayingList);
        } else {
          _filteredPopularMovies = genre.getFilteredList(_popularMovieList);
        }
      } else {
        _filteredTvShowsList = genre.getFilteredTvShowsList(_onTvList);
      }
    }
    notifyListeners();
  }

  bool _trendingListLoading = true;
  bool get trendingListLoading => _trendingListLoading;

  bool _popularListLoading = true;
  bool get popularListLoading => _popularListLoading;

  bool _actorsListLoading = true;
  bool get actorsListLoading => _actorsListLoading;

  bool _videosLoading = true;
  bool get videosLoading => _videosLoading;

  bool _nowPlayingListLoading = true;
  bool get nowPlayingListLoading => _nowPlayingListLoading;

  bool _onTVListLoading = true;
  bool get onTVListLoading => _onTVListLoading;

  bool _similarMovieListLoading = true;
  bool get similarMovieListLoading => _similarMovieListLoading;

  bool _similarTvShowsLoading = true;
  bool get similarTvShowsLoading => _similarTvShowsLoading;

  void updateTrendingListLoading(bool value) {
    _trendingListLoading = value;
    notifyListeners();
  }

  void updateActorsListLoading(bool value) {
    _actorsListLoading = value;
    notifyListeners();
  }

  void clearActorsAndSimilarList() {
    _actorsList.clear();
    _actorsListLoading = true;
    _similarMovieList.clear();
    _similarMovieListLoading = true;
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

  Future getPopularList() async {
    _popularListLoading = true;
    _popularMovieList = [];
    notifyListeners();

    _popularMovieList = await MovieRepo.getPopularList();
    _filteredPopularMovies = _popularMovieList;
    _popularListLoading = false;
    notifyListeners();
  }

  Future getNowPlayingList() async {
    _nowPlayingListLoading = true;
    _nowPlayingList = [];
    notifyListeners();
    _nowPlayingList = await MovieRepo.getNowPlayingList();
    _filteredNowPlayingList = _nowPlayingList;

    _nowPlayingListLoading = false;
    notifyListeners();
  }

  Future getOnTvList() async {
    _onTVListLoading = true;
    _onTvList = [];
    notifyListeners();

    _onTvList = await MovieRepo.getOnTvList();
    _filteredTvShowsList = _onTvList;
    _onTVListLoading = false;
    notifyListeners();
  }

  Future getGenres() async {
    _movieGenreList = await MovieRepo.getGenreList();
    _selectedGenre = _movieGenreList[0];
    notifyListeners();
  }

  Future getMovieDetails(int id) async {
    _selectedMovie = await MovieRepo.getMovieDetails(id);
    getActorsList(id);
    getVideoList(id);
    getSimilarMoviesList(id);
    notifyListeners();
  }

  Future getTvShowDetails(int id) async {
    _selectedShow = await MovieRepo.getTvShowDetails(id);
    getActorsList(id);
    getSimilarTvShowsList(id);
    notifyListeners();
  }

  Future getActorsList(int id) async {
    _actorsListLoading = true;
    _actorsList = [];
    _actorsList = await MovieRepo.getActorsList(id);

    _actorsListLoading = false;
    notifyListeners();
  }

  Future getVideoList(int id) async {
    _videosLoading = true;
    _videoList = [];
    _videoList = await MovieRepo.getRelatedVideos(id);

    _videosLoading = false;
    notifyListeners();
  }

  Future getSimilarMoviesList(int id) async {
    _similarMovieListLoading = true;
    _similarMovieList = [];
    notifyListeners();

    _similarMovieList = await MovieRepo.getSimilarMoviesList(id);

    _similarMovieListLoading = false;
    notifyListeners();
  }

  Future getSimilarTvShowsList(int id) async {
    _similarTvShowsLoading = true;
    _similarTvShowList = [];
    notifyListeners();
    _similarTvShowList = await MovieRepo.getSimilarTvShowList(id);
    _similarTvShowsLoading = false;
    notifyListeners();
  }
}
