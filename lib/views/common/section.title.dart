import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {super.key, required this.title, required this.seeMoreCallBack});
  final String title;
  final VoidCallback seeMoreCallBack;

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
        GestureDetector(
          onTap: () {
            seeMoreCallBack.call();
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
