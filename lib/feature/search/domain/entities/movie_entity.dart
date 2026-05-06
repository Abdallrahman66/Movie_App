class MovieEntity {
  final int id;
  final String title;
  final String image;
  final double voteAverage;
  final String publishDate;
  final String overview;

  MovieEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.voteAverage,
    required this.publishDate,
    required this.overview,
  });
}