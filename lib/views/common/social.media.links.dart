import 'package:flutter/material.dart';
import 'package:movie_app/model/social.media.model.dart';
import 'package:movie_app/views/common/social.media.icon.dart';

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({
    super.key,
    required this.model,
    this.isMobile = false,
  });

  final SocialMediaModel model;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    const String? kFontPkg = null;

    const kFontFam = 'social';
    const IconData twitterSquare = IconData(0xf081, fontFamily: kFontFam);
    const IconData facebookSquare =
        IconData(0xf082, fontFamily: kFontFam, fontPackage: kFontPkg);
    const IconData instagram =
        IconData(0xf16d, fontFamily: kFontFam, fontPackage: kFontPkg);
    const IconData wikipediaLogo =
        IconData(0xf266, fontFamily: kFontFam, fontPackage: kFontPkg);
    const IconData imdb =
        IconData(0xf2d8, fontFamily: kFontFam, fontPackage: kFontPkg);
    return Row(
      children: [
        if (model.fbId.isNotEmpty)
          SocialMediaIcon(
            link: 'https://fb.com/${model.fbId}',
            icon: facebookSquare,
            isMobile: isMobile,
          ),
        if (model.fbId.isNotEmpty) const SizedBox(width: 10),
        if (model.instaId.isNotEmpty)
          SocialMediaIcon(
            link: 'https://instagram.com/${model.instaId}',
            icon: instagram,
            isMobile: isMobile,

          ),
        if (model.instaId.isNotEmpty) const SizedBox(width: 10),
        if (model.twitterId.isNotEmpty)
          SocialMediaIcon(
            link: 'https://twitter.com/${model.twitterId}',
            icon: twitterSquare,
            isMobile: isMobile,

          ),
        if (model.twitterId.isNotEmpty) const SizedBox(width: 10),
        if (model.wikipediaId.isNotEmpty)
          SocialMediaIcon(
            link: 'https://en.wikipedia.org/wiki/${model.wikipediaId}',
            icon: wikipediaLogo,
            isMobile: isMobile,

          ),
        if (model.wikipediaId.isNotEmpty) const SizedBox(width: 10),
        if (model.imdbId.isNotEmpty)
          SocialMediaIcon(
            link: 'https://imdb.com/title/${model.imdbId}',
            icon: imdb,
            isMobile: isMobile,

          ),
        if (model.imdbId.isNotEmpty) const SizedBox(width: 10),
      ],
    );
  }
}
