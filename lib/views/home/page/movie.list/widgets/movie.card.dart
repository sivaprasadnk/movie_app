import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.poster,
    required this.name,
    required this.vote,
  }) : super(key: key);

  final String poster;
  final String name;
  final double vote;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: Image.network(
              poster,
              height: 155,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '1h 37m',
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 20),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 10,
              ),
              Text(
                vote.toString(),
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
