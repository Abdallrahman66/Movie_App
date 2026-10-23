
import 'package:flutter/material.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';

class MovieSynopsisSection extends StatelessWidget {
  const MovieSynopsisSection({
    super.key,
    required this.movie,
  });

  final DetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    if (movie.description.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'NARRATIVE SYNOPSIS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.description,
            style: const TextStyle(
              color: Color(0xFF85858D),
              fontSize: 14,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}
