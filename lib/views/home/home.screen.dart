import 'package:flutter/material.dart';
import 'package:movie_app/provider/app.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/bottom.nav.bar.dart';
import 'package:movie_app/views/home/page/activity.screen.dart';
import 'package:movie_app/views/home/page/movie.list/movie.list.screen.dart';
import 'package:movie_app/views/home/page/profile/profile.screen.dart';
import 'package:movie_app/views/home/page/search.screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.moviesProvider.getGenres();
      context.moviesProvider.getTrendingList();
      context.moviesProvider.getNowPlayingList();
      context.moviesProvider.getOnTvList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: const BottomNavBar(),
        body: Consumer<AppProvider>(
          builder: (_, provider, __) {
            switch (provider.selectedIndex) {
              case 0:
                return const MovieListScreen();
              case 1:
                return const SearchScreen();
              case 2:
                return const ActivityScreen();
              case 3:
                return const ProfileScreen();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
