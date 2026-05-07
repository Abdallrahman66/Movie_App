class MovieEntity {
  MovieEntity({
     this.id=0,
     this.title="",
     this.image="",
     this.voteAverage=0.0,
     this.publishDate="",
     this.overview="",
  });
  final int id;
  final String title;
  final String image;
  final double voteAverage;
  final String publishDate;
  final String overview;
}
