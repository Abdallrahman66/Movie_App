import 'package:movie_app/feature/home/data/model/recommended_movie_dto.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

extension RecommendedMovieMapper on RecommendedMovieDto {
  HomeMovieEntity toEntity() {
    return HomeMovieEntity(
      results:
          results
              ?.map(
                (e) => MovieItemEntity(
                  id: e.id ?? 0,
                  posterPath:
                      "https://image.tmdb.org/t/p/w500${e.posterPath ?? ""}",
                ),
              )
              .toList() ??
          [],
    );
  }
}
