import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';

class ActorsList extends StatelessWidget {
  const ActorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return SizedBox(
          height: 150,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 20);
            },
            itemCount: provider.actorsList.length,
            itemBuilder: (context, index) {
              var actor = provider.actorsList[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomCacheImage(
                    imageUrl: actor.profilePath,
                    borderRadius: 8,
                    height: 100,
                    width: 80,
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
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
