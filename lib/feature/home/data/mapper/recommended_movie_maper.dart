import 'package:movie_app/feature/home/data/model/recommended_movie_dto.dart';
import 'package:movie_app/feature/home/domain/entity/recommended_movie_entity.dart';

extension RecommendedMovieMapper on RecommendedMovieDto {
  RecommendedMovieEntity toEntity() {
    return RecommendedMovieEntity(
      page: page ?? 0,
      totalPages: totalPages ?? 0,
      totalResults: totalResults ?? 0,
      results: results?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension ResultsMapper on ResultsDto {
  ResultsEntity toEntity() {
    return ResultsEntity(
      adult: adult ?? false,
      backdropPath: backdropPath ?? "",
      genreIds: genreIds ?? [],
      id: id ?? 0,
      title: title ?? "",
      originalLanguage: originalLanguage ?? "",
      originalTitle: originalTitle ?? "",
      overview: overview ?? "",
      popularity: popularity ?? 0.0,
      posterPath: posterPath ?? "",
      releaseDate: releaseDate ?? "",
      softcore: softcore ?? false,
      video: video ?? false,
      voteAverage: voteAverage ?? 0.0,
      voteCount: voteCount ?? 0,
    );
  }
}
