import 'package:flutter/material.dart';
import 'package:movie_app/model/actors.model.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';

class ActorsListWeb extends StatelessWidget {
  const ActorsListWeb({
    Key? key,
    this.size = 180,
    this.height = 250,
  }) : super(key: key);

  final double size;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.actorsList.getList.isNotEmpty
            ? SizedBox(
                height: height,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 20);
                  },
                  itemCount: provider.actorsList.getList.length,
                  itemBuilder: (context, index) {
                    var actor = provider.actorsList.getList[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomCacheImage(
                          imageUrl: actor.profilePath,
                          borderRadius: size,
                          height: size,
                          width: size,
                          cacheKey: 'actor${actor.id}${actor.name}',
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 80,
                          child: Text(
                            actor.name,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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