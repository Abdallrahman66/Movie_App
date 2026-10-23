
import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';

class SimilarMovieCard extends StatelessWidget {
  const SimilarMovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  final SimilarEntity movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 126,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: SizedBox(
                height: 178,
                width: 126,
                child: movie.image.isEmpty
                    ? Container(
                        color: const Color(0xFF242A32),
                        child: const Icon(
                          Icons.movie_outlined,
                          color: Colors.white54,
                          size: 38,
                        ),
                      )
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          CacheNetworkImage(
                            imageUrl: movie.image,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 7,
                            top: 7,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.75),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 13,
                                    color: Color(0xFFD5B779),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              movie.releaseDate,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
