import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/title.app.bar.dart';
import 'package:movie_app/views/web/movie.details/large/movie.details.large.dart';
import 'package:movie_app/views/web/movie.details/small/movie.details.small.dart';

class MovieDetailsScreenWeb extends StatelessWidget {
  static const routeName = "/movie/";

  const MovieDetailsScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: const TitleAppBar(),
        body: SingleChildScrollView(
          child: context.width > 700
              ? const MovieDetailsLarge()
              : const MovieDetailsSmall(),
        ),
      ),
    );
  }
}
