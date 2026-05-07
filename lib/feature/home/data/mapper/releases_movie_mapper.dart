import 'package:movie_app/feature/home/data/model/releases_movie_dto.dart';
import 'package:movie_app/feature/home/domain/entity/releases_movie_entity.dart';

extension ReleasesMovieMapper on ReleasesMovieDto {
  ReleasesMovieEntity toEntity() {
    return ReleasesMovieEntity(
      page: page ?? 0,
      totalPages: totalPages ?? 0,
      totalResults: totalResults ?? 0,
      results: results?.map((e) => e.toEntity()).toList() ?? [],
      dates: dates?.toEntity() ?? const ReleasesDates(),
    );
  }
}

extension ResultsReleasesMapper on ResultReleasesDto {
  ResultReleasesEntity toEntity() {
    return ResultReleasesEntity(

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

extension ReleasesDatesMapper on ReleasesDatesDto {
  ReleasesDates toEntity() {
    return ReleasesDates(maximum: maximum ?? "", minimum: minimum ?? "");
  }
}
