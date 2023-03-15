// import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoList extends StatelessWidget {
  const VideoList({
    super.key,
    this.isWeb = false,
  });
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    IconData youtube =
        const IconData(0xf167, fontFamily: 'youtube', fontPackage: null);
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.videoList.isNotEmpty
            ? SizedBox(
                height: 250,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 20);
                  },
                  itemCount: provider.videoList.length,
                  itemBuilder: (context, index) {
                    var video = provider.videoList[index];

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var link =
                                "https://www.youtube.com/watch?v=${video.key}";
                            if (isWeb) {
                              // html.window.open(link, 'new tab');
                            } else {
                              var url = Uri.parse(link);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                if (context.mounted) {
                                  context.scaffoldMessenger.showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Could not launch $url')));
                                  // throw 'Could not launch $url';
                                }
                              }
                            }
                          },
                          child: Stack(
                            children: [
                              CustomCacheImage(
                                imageUrl: video.thumbnail,
                                borderRadius: 10,
                                height: 200,
                                width: 250,
                                cacheKey: 'video${video.id}${video.key}',
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    youtube,
                                    color: Colors.red,
                                    size: 75,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                              video.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
