import 'package:flutter/material.dart';
import 'package:movie_app/views/common/section.title.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/ontv.list.dart';

class TvShowSectionMobile extends StatelessWidget {
  const TvShowSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: 'Top Rated',
          withSeeMore: true,
          seeMoreCallBack: () {},
        ),
        const SizedBox(height: 20),
        const TvShowList()
      ],
    );
  }
}
