
import 'package:flutter/material.dart';
import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/similar_movie_card.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  final List<SimilarEntity> movies;
  final ValueChanged<int> onMovieTap;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'More Like This',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                'CURATED RAIL',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 10,
                  letterSpacing: 0.7,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 238,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final movie = movies[index];

              return SimilarMovieCard(
                movie: movie,
                onTap: () => onMovieTap(movie.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
