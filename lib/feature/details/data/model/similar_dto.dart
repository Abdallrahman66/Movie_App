import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';

const _tmdbImageBase = 'https://image.tmdb.org/t/p/w500';

class SimilarDto {
  SimilarDto.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'];

    if (rawResults is List) {
      results = rawResults
          .whereType<Map>()
          .map((item) {
            final posterPath = item['poster_path'] as String?;
            final date = item['release_date'] as String? ?? '';

            return SimilarEntity(
              id: (item['id'] as num?)?.toInt() ?? 0,
              image: posterPath == null || posterPath.isEmpty
                  ? ''
                  : '$_tmdbImageBase$posterPath',
              title: (item['title'] as String?) ?? 'Untitled movie',
              releaseDate: date.length >= 4 ? date.substring(0, 4) : 'Year N/A',
              voteAverage: (item['vote_average'] as num?)?.toDouble() ?? 0,
            );
          })
          .where((movie) => movie.id > 0)
          .toList(growable: false);
    } else {
      results = const [];
    }
  }

  late final List<SimilarEntity> results;

  List<SimilarEntity> toEntity() => results;
}
