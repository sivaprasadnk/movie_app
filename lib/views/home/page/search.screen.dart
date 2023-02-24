import 'package:flutter/material.dart';

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
        Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
