class DetailsEntity {
  const DetailsEntity({
    required this.coverImage,
    required this.image,
    required this.publishDate,
    required this.categories,
    required this.timeOfMovie,
    required this.title,
    required this.tagline,
    required this.description,
    required this.voteAverage,
    required this.cast,
    required this.crew,
  });

  final String coverImage;
  final String image;
  final String publishDate;
  final List<String> categories;
  final String timeOfMovie;
  final String title;
  final String tagline;
  final String description;
  final double voteAverage;
  final List<MovieCreditEntity> cast;
  final List<MovieCreditEntity> crew;
}

class MovieCreditEntity {
  const MovieCreditEntity({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.role,
  });

  final int id;
  final String name;
  final String profileImage;

 
  final String role;
}
