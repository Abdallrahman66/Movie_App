import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';

class MovieDto {
  MovieDto({this.page, this.results, this.totalPages, this.totalResults});
  int? page;

  List<MovieDataModel>? results;

  int? totalPages;

  int? totalResults;

  MovieDto.fromJson(Map<String, dynamic> json) {
    page = json['page'];

    if (json['results'] != null) {
      results = <MovieDataModel>[];

      json['results'].forEach((v) {
        results!.add(MovieDataModel.fromJson(v));
      });
    }

    totalPages = json['total_pages'];

    totalResults = json['total_results'];
  }
}

class MovieDataModel {

  MovieDataModel({
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

  MovieDataModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];

    backdropPath = json['backdrop_path'];

    genreIds = json['genre_ids']?.cast<int>();

    id = json['id'];

    title = json['title'];

    originalLanguage = json['original_language'];

    originalTitle = json['original_title'];

    overview = json['overview'];

    popularity = (json['popularity'] as num?)?.toDouble();

    posterPath = json['poster_path'];

    releaseDate = json['release_date'];

    softcore = json['softcore'];

    video = json['video'];

    voteAverage = (json['vote_average'] as num?)?.toDouble();

    voteCount = json['vote_count'];
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id ?? 0,

      title: title ?? "No Title",

      image: (posterPath != null)
          ? "https://image.tmdb.org/t/p/w500$posterPath"
          : "https://img.pikbest.com/backgrounds/20190729/white-wrinkled-paper-background-image_2769903.jpg!w700wp",

      voteAverage: voteAverage ?? 0.0,

      publishDate: releaseDate?.split('-').first ?? "0000",

      overview: overview ?? "No Description",

      genre: getGenre(),
    );
  }

  String getGenre() {
    if (genreIds == null || genreIds!.isEmpty) {
      return "Movie";
    }

    final genres = {
      28: "Action",

      12: "Adventure",

      16: "Animation",

      35: "Comedy",

      18: "Drama",

      27: "Horror",

      878: "Sci-Fi",

      53: "Thriller",
    };

    return genres[genreIds!.first] ?? "Movie";
  }
}
