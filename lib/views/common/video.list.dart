// import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';

class VideoList extends StatelessWidget {
  const VideoList({super.key});

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
                          onTap: () {
                            // var link =
                            //     "https://www.youtube.com/watch?v=${video.key}";
                            // html.window.open(link, 'new tab');
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
