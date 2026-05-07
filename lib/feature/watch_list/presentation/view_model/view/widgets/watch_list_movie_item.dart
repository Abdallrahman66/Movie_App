import 'package:flutter/material.dart';
import 'package:movie_app/feature/watch_list/domain/entities/watch_list_entity.dart';

class WatchListMovieItem extends StatelessWidget {
  const WatchListMovieItem({super.key, required this.movie, this.onRemove});

  final WatchListEntity movie;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie.image,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 140,
                color: Colors.grey[800],
                child: const Icon(Icons.broken_image, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.amber, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  movie.category,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.publishDate,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.timeOfMovie,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.bookmark, color: Colors.amber),
          ),
        ],
      ),
    );
  }
}
