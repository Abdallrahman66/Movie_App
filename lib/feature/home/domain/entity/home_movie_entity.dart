class HomeMovieEntity {
  HomeMovieEntity({required this.results});

  final List<MovieItemEntity> results;
}

class MovieItemEntity {
  const MovieItemEntity({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.overview,
  });

  final int id;
  final String posterPath;
  final String title;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final String overview;
}
