import 'package:flutter/material.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/cast_crew_section.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/movie_hero_section.dart';
import 'package:movie_app/feature/details/presentation/view/widgets/movie_synopsis_section.dart';

class ViewMovieWidget extends StatelessWidget {
  const ViewMovieWidget({super.key, required this.movieDetails});

  final DetailsEntity movieDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieHeroSection(movie: movieDetails),

        const SizedBox(height: 4),

        MovieSynopsisSection(movie: movieDetails),

        const SizedBox(height: 28),

        CastCrewSection(title: 'FEATURED CAST', credits: movieDetails.cast),

        if (movieDetails.crew.isNotEmpty) ...[
          const SizedBox(height: 24),
          CastCrewSection(
            title: 'CREW',
            credits: movieDetails.crew.take(8).toList(),
          ),
        ],
      ],
    );
  }
}
