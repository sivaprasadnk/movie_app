import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/home/page/profile/bookmark.list.screen.dart';
import 'package:movie_app/views/home/page/profile/widgets/profile.menu.card.dart';

class BookmarkListMenu extends StatefulWidget {
  const BookmarkListMenu({super.key, required this.isGuest});
  final bool isGuest;

  @override
  State<BookmarkListMenu> createState() => _BookmarkListMenuState();
}

class _BookmarkListMenuState extends State<BookmarkListMenu> {
  int count = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      count = (await context.userProvider.getBookmarksCount()).length;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileMenuCard(
      title: 'Bookmark List',
      icon: Icons.bookmark,
      isCountItem: true,
      count: widget.isGuest ? 0 : count,
      isImplemented: true,
      onTap: () {
        context.userProvider.clearList();
        Navigator.pushNamed(context, BookmarkListScreen.routeName);
      },
    );
  }
}
