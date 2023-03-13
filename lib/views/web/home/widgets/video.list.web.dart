import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';

class VideoListWeb extends StatelessWidget {
  const VideoListWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        if (!provider.videosLoading) {
          debugPrint(provider.videoList[0].thumbnail);
        }
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
                    debugPrint(video.name);
                    debugPrint(video.thumbnail);

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomCacheImage(
                          imageUrl: video.thumbnail,
                          borderRadius: 10,
                          height: 200,
                          width: 250,
                          cacheKey: 'video${video.id}${video.key}',
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
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
