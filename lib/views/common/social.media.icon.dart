import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({super.key, required this.link, required this.icon});

  final String link;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    var color = Colors.white;
    double size = 25;
    return GestureDetector(
      onTap: () {
        if (kIsWeb) {
          html.window.open(link, 'new tab');
        } else {}
      },
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    ).addMousePointer;
  }
}
