class ReleasesMovieEntity {
  ReleasesMovieEntity({
    this.dates = const ReleasesDates(),
    this.page = 0,
    this.results = const [],
    this.totalPages = 0,
    this.totalResults = 0,
  });
  final ReleasesDates dates;
  final int page;
  final List<ResultReleasesEntity> results;
  final int totalPages;
  final int totalResults;
}

class ReleasesDates {
  const ReleasesDates({this.maximum = "", this.minimum = ""});
  final String maximum;
  final String minimum;
}

class ResultReleasesEntity {
  ResultReleasesEntity({
    this.adult = false,
    this.backdropPath = "",
    this.genreIds = const [],
    this.id = 0,
    this.title = "",
    this.originalLanguage = "",
    this.originalTitle = "",
    this.overview = "",
    this.popularity = 0.0,
    this.posterPath = "",
    this.releaseDate = "",
    this.softcore = false,
    this.video = false,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final bool softcore;
  final bool video;
  final double voteAverage;
  final int voteCount;
}
