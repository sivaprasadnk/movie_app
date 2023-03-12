import 'package:flutter/material.dart';
import 'package:movie_app/provider/app.provider.dart';
import 'package:movie_app/provider/auth.provider.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/provider/user.provider.dart';
import 'package:provider/provider.dart';

extension ContextExtensions on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;

  // int get gridCrossAxisCount => width > 1200
  //     ? 5
  //     : width > 920
  //         ? 4
  //         : width > 685
  //             ? 3
  //             : 2;

  int get gridCrossAxisCount => width > 1200
      ? 5
      : width > 920
          ? 4
          : width > 685
              ? 3
              : 2;

  int get gridLimit => width > 1200
      ? 5
      : width > 920
          ? 4
          : width > 685
              ? 3
              : 2;            

  MoviesProvider get moviesProvider =>
      Provider.of<MoviesProvider>(this, listen: false);

  AuthProvider get authProvider =>
      Provider.of<AuthProvider>(this, listen: false);

  UserProvider get userProvider =>
      Provider.of<UserProvider>(this, listen: false);

  AppProvider get appProvider => Provider.of<AppProvider>(this, listen: false);


  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  ThemeData get theme => Theme.of(this);
  
  void pop() {
    Navigator.pop(this);
  }

  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}
