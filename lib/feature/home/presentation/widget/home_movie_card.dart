import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

class HomeMovieCard extends StatelessWidget {
  const HomeMovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    this.width = 160,
    this.animationDelay = Duration.zero,
  });
  final MovieItemEntity movie;
  final VoidCallback onTap;
  final double width;
  final Duration animationDelay;
  String? get _releaseYear {
    final releaseDate = movie.releaseDate;
    if (releaseDate.length < 4) {
      return null;
    }

    return releaseDate.substring(0, 4);
  }

  @override
  Widget build(BuildContext context) {
    final posterHeight = width * 1.45;
    return TweenAnimationBuilder<double>(
      key: ValueKey(movie.id),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      builder: (context, animationValue, child) {
        return Opacity(
          opacity: animationValue,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - animationValue)),
            child: child,
          ),
        );
      },
      child: SizedBox(
        width: width,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: width,
                        height: posterHeight,
                        child: CacheNetworkImage(imageUrl: movie.posterPath),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: _RatingBadge(rating: movie.voteAverage),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColor.primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                if (_releaseYear != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    _releaseYear!,
                    style: TextStyle(
                      color: AppColor.primaryTextColor.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating});
  final double? rating;
  @override
  Widget build(BuildContext context) {
    if (rating == null) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 15),
          const SizedBox(width: 4),
          Text(
            rating!.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
