import 'package:flutter/material.dart';

import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/movie_information_section.dart';

class MovieHeroSection extends StatelessWidget {
  const MovieHeroSection({super.key, required this.movie});

  final DetailsEntity movie;

  static const Color _gold = Color(0xFFC9A96E);
  static const Color _muted = Color(0xFF92929D);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final compact = screenWidth < 360;

    final heroHeight = (screenWidth * 0.43).clamp(145.0, 190.0);
    final posterWidth = compact ? 96.0 : 108.0;
    final posterHeight = compact ? 144.0 : 162.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: heroHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(movie.coverImage, fit: BoxFit.cover),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x18000000),
                          Color(0x44000000),
                          Color(0xAA000000),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: _gold,
                            size: 15,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${movie.voteAverage.toStringAsFixed(1)} / 10',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
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

          Transform.translate(
            offset: const Offset(0, -22),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: posterWidth,
                    height: posterHeight,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D1F24),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.45),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: _buildImage(movie.image, fit: BoxFit.cover),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (movie.tagline.trim().isNotEmpty) ...[
                            Text(
                              movie.tagline.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _gold,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.9,
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],

                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: compact ? 15 : 17,
                              fontWeight: FontWeight.w700,
                              height: 1.25,
                            ),
                          ),

                          const SizedBox(height: 12),

                          MovieInformationSection(movie: movie),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url, {required BoxFit fit}) {
    if (url.trim().isEmpty) {
      return Container(
        color: const Color(0xFF242A32),
        alignment: Alignment.center,
        child: const Icon(Icons.movie_outlined, color: _muted, size: 34),
      );
    }

    return CacheNetworkImage(imageUrl: url, fit: fit);
  }
}
