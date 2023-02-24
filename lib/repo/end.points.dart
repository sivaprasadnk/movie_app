import 'package:movie_app/repo/api.key.dart';

String kBaseUrl = "https://api.themoviedb.org/3/";
String kImageBaseUrl = "https://image.tmdb.org/t/p/w500/";
String kMoviesUrl = "${kBaseUrl}trending/movie/week?api_key=$apiKey";
String kPlayingNowUrl =
    "${kBaseUrl}movie/now_playing?api_key=$apiKey&language=en-US";
String kTvShowsUrl = "${kBaseUrl}tv/popular?api_key=$apiKey&language=en-US";
String kPopularMoviesUrl =
    "${kBaseUrl}movie/top_rated?api_key=$apiKey&language=en-US";
String kGenreUrl = "${kBaseUrl}genre/movie/list?api_key=$apiKey";
