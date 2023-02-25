import 'package:movie_app/repo/movie/api.key.dart';

String kBaseUrl = "https://api.themoviedb.org/3/";
String kImageBaseUrl = "https://image.tmdb.org/t/p/w500/";
String kMoviesUrl = "${kBaseUrl}trending/movie/week?api_key=$apiKey";
String kPlayingNowUrl =
    "${kBaseUrl}movie/now_playing?api_key=$apiKey&language=en-US";
String kTvShowsUrl = "${kBaseUrl}tv/popular?api_key=$apiKey&language=en-US";
String kPopularMoviesUrl =
    "${kBaseUrl}movie/top_rated?api_key=$apiKey&language=en-US";
String kGenreUrl = "${kBaseUrl}genre/movie/list?api_key=$apiKey";
String kActorsUrl =
    "https://api.themoviedb.org/3/movie/505642/credits?api_key=c5f91272e8db79e3deb27701f18d2894";
