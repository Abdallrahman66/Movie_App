import '../../domain/entities/watch_list_movie_entity.dart';

class WatchListMovieModel extends WatchListMovieEntity {
  const WatchListMovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.voteAverage,
    required super.releaseDate,
    required super.overview,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'releaseDate': releaseDate,
      'overview': overview,
    };
  }

  factory WatchListMovieModel.fromEntity(WatchListMovieEntity entity) {
    return WatchListMovieModel(
      id: entity.id,
      title: entity.title,
      posterPath: entity.posterPath,
      voteAverage: entity.voteAverage,
      releaseDate: entity.releaseDate,
      overview: entity.overview,
    );
  }

  factory WatchListMovieModel.fromMap(Map<dynamic, dynamic> map) {
    return WatchListMovieModel(
      id: (map['id'] as num).toInt(),
      title: map['title'] as String? ?? '',
      posterPath: map['posterPath'] as String? ?? '',
      voteAverage: (map['voteAverage'] as num?)?.toDouble() ?? 0.0,
      releaseDate: map['releaseDate'] as String? ?? '',
      overview: map['overview'] as String? ?? '',
    );
  }
}
