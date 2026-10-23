class SimilarEntity {
  const SimilarEntity({
    required this.image,
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
  });

  final String image;
  final int id;
  final String title;
  final String releaseDate;
  final double voteAverage;
}
