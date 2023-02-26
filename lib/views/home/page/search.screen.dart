import 'package:flutter/material.dart';
import 'package:movie_app/views/common/page.title.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PageTitle(title: 'Search'),
      ],
    );
  }
}
