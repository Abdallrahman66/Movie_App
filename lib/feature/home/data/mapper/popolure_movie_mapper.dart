import 'package:movie_app/feature/home/data/model/popolure_movie_dto.dart';

import 'package:movie_app/feature/home/domain/entity/popular_movie_entity.dart';

extension PopolureMovieMapper on PopolureMovieDto {
  PopolureMovieEntity toEntity() {
    return PopolureMovieEntity(
      page: page ?? 0,
      results: results?.map((e) => e.toEntity()).toList() ?? [],
      totalPages: totalPages ?? 0,
      totalResults: totalResults ?? 0,
    );
  }
}

extension ResultsPopolureMapper on ResultsPopoluredto {
  ResultsPopolureEntity toEntity() {
    return ResultsPopolureEntity(
      adult: adult ?? false,
      backdropPath: backdropPath ?? "",
      genreIds: genreIds ?? [],
      id: id ?? 0,
      title: title ?? "",
      originalLanguage: originalLanguage ?? "",
      originalTitle: originalTitle ?? "",
      overview: overview ?? "",
      popularity: popularity ?? 0.0,
      posterPath: "https://image.tmdb.org/t/p/w500${posterPath ?? ""}",
      releaseDate: releaseDate ?? "",
      softcore: softcore ?? false,
      video: video ?? false,
      voteAverage: voteAverage ?? 0.0,
      voteCount: voteCount ?? 0,
    );
  }
}
