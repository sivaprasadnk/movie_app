import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.seeMoreCallBack,
    this.withSeeMore = false,
  });
  final String title;
  final VoidCallback? seeMoreCallBack;
  final bool withSeeMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        const Spacer(),
        if (withSeeMore)
        GestureDetector(
          onTap: () {
              seeMoreCallBack!.call();
          },
          child: const Text(
            "See all",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 2),
        if (withSeeMore)

        const Icon(
          Icons.arrow_forward_ios,
          size: 9,
          color: Colors.grey,
        ),
        const SizedBox(width: 20)
      ],
    );
  }
}
