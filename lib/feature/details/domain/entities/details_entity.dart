class DetailsEntity {
  DetailsEntity({
    required this.coverImage,
    required this.image,
    required this.publishDate,
    required this.category,
    required this.timeOfMovie,
    required this.title,
    required this.description,
  });

  String coverImage;
  String image;
  DateTime publishDate;
  String category;
  String timeOfMovie;
  String title;
  String description;
}
