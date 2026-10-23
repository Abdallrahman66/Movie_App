import 'package:movie_app/feature/details/domain/entities/details_entity.dart';

const _tmdbImageBase = 'https://image.tmdb.org/t/p/w500';

class DetailsDto {
  DetailsDto.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'] as String?;
    posterPath = json['poster_path'] as String?;
    releaseDate = json['release_date'] as String?;
    runtime = (json['runtime'] as num?)?.toInt();
    tagline = json['tagline'] as String?;
    title = json['title'] as String?;
    overview = json['overview'] as String?;
    voteAverage = (json['vote_average'] as num?)?.toDouble() ?? 0;

    final rawGenres = json['genres'];

    if (rawGenres is List) {
      genres = rawGenres
          .whereType<Map>()
          .map((item) => item['name'])
          .whereType<String>()
          .where((name) => name.trim().isNotEmpty)
          .toList(growable: false);
    }

    final rawCredits = json['credits'];

    if (rawCredits is Map) {
      final rawCast = rawCredits['cast'];

      if (rawCast is List) {
        cast = rawCast
            .whereType<Map>()
            .map(
              (item) => MovieCreditEntity(
                id: (item['id'] as num?)?.toInt() ?? 0,
                name: (item['name'] as String?)?.trim().isNotEmpty == true
                    ? item['name'] as String
                    : 'Unknown',
                profileImage: _image(item['profile_path'] as String?),
                role: (item['character'] as String?) ?? '',
              ),
            )
            .where((item) => item.id > 0)
            .take(12)
            .toList(growable: false);
      }

      final rawCrew = rawCredits['crew'];

      if (rawCrew is List) {
        crew = rawCrew
            .whereType<Map>()
            .map(
              (item) => MovieCreditEntity(
                id: (item['id'] as num?)?.toInt() ?? 0,
                name: (item['name'] as String?)?.trim().isNotEmpty == true
                    ? item['name'] as String
                    : 'Unknown',
                profileImage: _image(item['profile_path'] as String?),
                role:
                    (item['job'] as String?) ??
                    (item['department'] as String?) ??
                    '',
              ),
            )
            .where((item) => item.id > 0)
            .take(12)
            .toList(growable: false);
      }
    }
  }

  String? backdropPath;
  String? posterPath;
  String? releaseDate;
  int? runtime;
  String? tagline;
  String? title;
  String? overview;

  double voteAverage = 0;

  List<String> genres = const [];

  List<MovieCreditEntity> cast = const [];

  List<MovieCreditEntity> crew = const [];

  DetailsEntity toEntity() {
    return DetailsEntity(
      coverImage: _image(backdropPath),
      image: _image(posterPath),
      publishDate: _year(releaseDate),
      categories: genres,
      timeOfMovie: runtime != null && runtime! > 0
          ? '$runtime Minutes'
          : 'Runtime N/A',
      title: title?.trim().isNotEmpty == true
          ? title!.trim()
          : 'Untitled movie',
      tagline: tagline?.trim() ?? '',
      description: overview?.trim().isNotEmpty == true
          ? overview!.trim()
          : 'No synopsis is available for this movie yet.',
      voteAverage: voteAverage,
      cast: cast,
      crew: crew,
    );
  }

  static String _image(String? path) {
    if (path == null || path.isEmpty) {
      return '';
    }

    return '$_tmdbImageBase$path';
  }

  static String _year(String? date) {
    if (date != null && date.length >= 4) {
      return date.substring(0, 4);
    }

    return 'Year N/A';
  }
}
