import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.seeMoreCallBack,
    this.withSeeMore = false,
    this.isWeb = false,
  });
  final String title;
  final VoidCallback? seeMoreCallBack;
  final bool withSeeMore;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: context.theme.primaryColor,
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
        SizedBox(width: isWeb ? context.width * 0.2 : 20)
      ],
    );
  }
}
