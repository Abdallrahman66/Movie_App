class WatchListMovieEntity {
  const WatchListMovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final String overview;
}
