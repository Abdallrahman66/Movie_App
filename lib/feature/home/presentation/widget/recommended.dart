import 'package:flutter/material.dart';
import 'package:movie_app/core/widgets/cache_networkImage_widget.dart';

class RecommendedMovieCarousel extends StatefulWidget {
  const RecommendedMovieCarousel({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  final List<dynamic> movies;
  final ValueChanged<dynamic> onMovieTap;

  @override
  State<RecommendedMovieCarousel> createState() =>
      _RecommendedMovieCarouselState();
}

class _RecommendedMovieCarouselState extends State<RecommendedMovieCarousel> {
  late final PageController _pageController;

  static const double _viewportFraction = 0.72;
  static const double _carouselHeight = 350;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: _viewportFraction);
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

              // Keep side posters close to the active poster.
              final scale = 1.0 - (distance * 0.15);

              // Slight vertical offset for the side posters.
              final verticalOffset = distance * 12;

              // Subtle 3D rotation.
              final rotation = (difference * 0.08).clamp(-0.10, 0.10);

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

  Widget _buildMoviePoster(dynamic movie) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF49423E), width: 1.5),
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
            CacheNetworkImage(
              imageUrl: movie.posterPath,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(20),
            ),

            // Dark cinematic gradient.
            IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.30),
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
