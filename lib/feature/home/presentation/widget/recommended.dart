import 'package:flutter/material.dart';

import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

class RecommendedMovieCarousel extends StatefulWidget {
  const RecommendedMovieCarousel({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  final List<MovieItemEntity> movies;
  final ValueChanged<MovieItemEntity> onMovieTap;

  @override
  State<RecommendedMovieCarousel> createState() =>
      _RecommendedMovieCarouselState();
}

class _RecommendedMovieCarouselState
    extends State<RecommendedMovieCarousel> {
  late final PageController _pageController;

  static const double _viewportFraction = 0.72;
  static const double _carouselHeight = 350;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: _viewportFraction,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: _carouselHeight,
      child: PageView.builder(
        controller: _pageController,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          return AnimatedBuilder(
            animation: _pageController,
            child: _buildMoviePoster(movie),
            builder: (context, child) {
              final currentPage = _pageController.hasClients
                  ? _pageController.page ??
                      _pageController.initialPage.toDouble()
                  : _pageController.initialPage.toDouble();

              final difference = index - currentPage;
              final distance = difference.abs().clamp(0.0, 1.0);

              final scale = 1.0 - (distance * 0.15);
              final verticalOffset = distance * 12;
              final rotation =
                  (difference * 0.08).clamp(-0.10, 0.10);

              return Transform.translate(
                offset: Offset(0, verticalOffset),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(rotation),
                  child: Transform.scale(
                    scale: scale,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => widget.onMovieTap(movie),
                      child: child,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildMoviePoster(MovieItemEntity movie) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF49423E),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 12,
            spreadRadius: 0.5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Movie poster.
            CacheNetworkImage(
              imageUrl: movie.posterPath,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(20),
            ),

            // Gradient for better text visibility.
            IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.40),
                      Colors.transparent,
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.92),
                    ],
                    stops: const [
                      0.0,
                      0.30,
                      0.58,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),

            // Movie rating.
            Positioned(
              top: 12,
              left: 12,
              child: _buildRatingBadge(movie.voteAverage),
            ),

            // Movie title and release year.
            Positioned(
              left: 12,
              right: 12,
              bottom: 14,
              child: _buildMovieInformation(movie),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.78),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: Color(0xFFFFC857),
            size: 15,
          ),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieInformation(MovieItemEntity movie) {
    final title = movie.title.trim();
    final releaseYear = _extractReleaseYear(movie.releaseDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              height: 1.2,
              fontWeight: FontWeight.w800,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),

        if (releaseYear != null) ...[
          const SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: Color(0xFFE0D6CF),
                size: 13,
              ),
              const SizedBox(width: 5),
              Text(
                releaseYear,
                style: const TextStyle(
                  color: Color(0xFFE0D6CF),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  String? _extractReleaseYear(String releaseDate) {
    final normalizedDate = releaseDate.trim();

    if (normalizedDate.length < 4) {
      return null;
    }

    final year = normalizedDate.substring(0, 4);

    if (int.tryParse(year) == null) {
      return null;
    }

    return year;
  }
}
