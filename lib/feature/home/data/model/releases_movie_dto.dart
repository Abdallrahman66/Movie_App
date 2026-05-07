class ReleasesMovieDto {
  ReleasesMovieDto({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });
  ReleasesDatesDto? dates;
  int? page;
  List<ResultReleasesDto>? results;
  int? totalPages;
  int? totalResults;


  ReleasesMovieDto.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? new ReleasesDatesDto.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = <ResultReleasesDto>[];
      json['results'].forEach((v) {
        results!.add(new ResultReleasesDto.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.dates != null) {
  //     data['dates'] = this.dates!.toJson();
  //   }
  //   data['page'] = this.page;
  //   if (this.results != null) {
  //     data['results'] = this.results!.map((v) => v.toJson()).toList();
  //   }
  //   data['total_pages'] = this.totalPages;
  //   data['total_results'] = this.totalResults;
  //   return data;
  // }
}

class ReleasesDatesDto {
  ReleasesDatesDto({this.maximum, this.minimum});
  String? maximum;
  String? minimum;


  ReleasesDatesDto.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['maximum'] = this.maximum;
  //   data['minimum'] = this.minimum;
  //   return data;
  // }
}

class ResultReleasesDto {
  ResultReleasesDto({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  bool? softcore;
  bool? video;
  double? voteAverage;
  int? voteCount;


  ResultReleasesDto.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    softcore = json['softcore'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }


}
