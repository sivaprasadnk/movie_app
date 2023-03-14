import 'package:flutter/material.dart';
import 'package:movie_app/model/actors.model.dart';
import 'package:movie_app/provider/movies.provider.dart';
import 'package:movie_app/views/common/custom.cache.image.dart';
import 'package:provider/provider.dart';
class ActorsListWeb extends StatelessWidget {
  const ActorsListWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return provider.actorsList.getList.isNotEmpty
            ? SizedBox(
                height: 250,
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
                          borderRadius: 180,
                          height: 180,
                          width: 180,
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
