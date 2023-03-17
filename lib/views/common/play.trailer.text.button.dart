import 'package:flutter/material.dart';
import 'package:movie_app/model/related.video.model.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/utils/extensions/widget.extensions.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../provider/movies.provider.dart';

class PlayTrailerTextButton extends StatelessWidget {
  const PlayTrailerTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(builder: (_, provider, __) {
      var trailerVideo = "";
      if (provider.videoList.isNotEmpty &&
          provider.videoList.trailer.isNotEmpty) {
        trailerVideo = provider.videoList.trailer;
      }
      return trailerVideo.isNotEmpty
          ? GestureDetector(
              onTap: () {
                playVideo(trailerVideo, context);
              },
              child: SizedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.play_arrow_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Play Trailer',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ).addMousePointer
          : const SizedBox.shrink();
    });
  }

  playVideo(String videoId, BuildContext context) async {
    final controller = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    showDialog(
      barrierColor: Colors.black87,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: YoutubePlayer(
                  controller: controller,
                  // aspectRatio: 4 / 3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}