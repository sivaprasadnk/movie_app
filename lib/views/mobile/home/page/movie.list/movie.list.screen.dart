import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/common/region.select.screen.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/content.selection.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/movie.section.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/trending.movie.carousal.dart';
import 'package:movie_app/views/mobile/home/page/movie.list/widgets/tvshow.section.mobile.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TrendingMovieCarousal(),
          const SizedBox(height: 20),
          Consumer<MoviesProvider>(builder: (_, provider, __) {
            var selected = provider.selectedRegion;
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Country :'),
                const SizedBox(width: 10),
                Text(
                  selected,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const RegionSelectScreenMobile();
                    }));
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 15,
                  ),
                ),
                // DropdownButton<String>(
                //   value: selected,
                //   selectedItemBuilder: (context) {
                //     return regionList.map((e) => Text(e)).toList();
                //   },

                //   onChanged: (value) {
                //     provider.updateRegion(value!);
                //   },
                //   items: regionList.map((region) {
                //     return DropdownMenuItem<String>(
                //       value: region,
                //       child: Text(region),
                //     );
                //   }).toList(),
                // ),
                const SizedBox(width: 10),
              ],
            );
          }),
          const SizedBox(height: 20),
          Consumer<MoviesProvider>(builder: (_, provider, __) {
            var selected = provider.selectedContentType;
            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContentSelection(
                    provider: provider,
                    selected: selected,
                  ),
                  const SizedBox(height: 20),
                  if (selected == Content.movie) const MovieSectionMobile(),
                  if (selected == Content.tvShow) const TvShowSectionMobile(),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
