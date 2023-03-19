import 'package:flutter/material.dart';
import 'package:movie_app/views/common/auth/sign.in/sign.in.screen.dart';
import 'package:movie_app/views/common/auth/sign.up/sign.up.screen.dart';
import 'package:movie_app/views/mobile/home/home.screen.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/details/movie.details.screen.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/details/tv.show.details.screen.dart';
import 'package:movie_app/views/mobile/home/page/profile/bookmark.list.screen.dart';
import 'package:movie_app/views/mobile/splash.screen/splash.screen.dart';
import 'package:movie_app/views/web/home/home.screen.web.dart';
import 'package:movie_app/views/web/movie.details/movie.details.screen.web.dart';
import 'package:movie_app/views/web/movie.details/tvshow.details.screen.web.dart';

final routes = <String, WidgetBuilder>{
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreenMobile.routeName: (context) => const HomeScreenMobile(),
  HomeScreenWeb.routeName: (context) => const HomeScreenWeb(),
  SplashScreenMobile.routeName: (context) => const SplashScreenMobile(),
  MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(),
  MovieDetailsScreenWeb.routeName: (context) => const MovieDetailsScreenWeb(),
  TvShowDetailsScreen.routeName: (context) => const TvShowDetailsScreen(),
  TvShowDetailsScreenWeb.routeName: (context) => const TvShowDetailsScreenWeb(),
  BookmarkListScreen.routeName: (context) => const BookmarkListScreen(),
};
