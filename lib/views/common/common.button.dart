import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.callback,
    required this.title,
  });

  final VoidCallback callback;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback.call();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
