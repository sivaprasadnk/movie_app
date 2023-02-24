import 'package:flutter/material.dart';
import 'package:movie_app/views/auth/sign.in/sign.in.screen.dart';
import 'package:movie_app/views/auth/sign.up/sign.up.screen.dart';
import 'package:movie_app/views/home/home.screen.dart';

final routes = <String, WidgetBuilder>{
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
};
