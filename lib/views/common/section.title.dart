import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';

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
            child: Row(
              children: const [
                Text(
                  "See all",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 9,
                  color: Colors.grey,
                ),
              ],
            ),
          ).addMousePointer,
        if (withSeeMore) SizedBox(width: isWeb ? context.width * 0.2 : 20)
      ],
    );
  }
}
