import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Text("Sign In"),
    ).addMousePointer;
  }
}
