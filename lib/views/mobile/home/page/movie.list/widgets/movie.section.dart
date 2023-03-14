import 'package:flutter/material.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/now.playing.list.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/popular.movies.list.dart';

class MovieSectionMobile extends StatelessWidget {
  const MovieSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Now Playing',
          withSeeMore: true,
          seeMoreCallBack: () {},
        ),
        const SizedBox(height: 20),
        const NowPlayingListMobile(limit: 5),
        const SizedBox(height: 20),
        SectionTitle(
          title: 'Popular Movies',
          withSeeMore: true,
          seeMoreCallBack: () {},
        ),
        const SizedBox(height: 20),
        const PopularMoviesList(),
      ],
    );
  }
}
