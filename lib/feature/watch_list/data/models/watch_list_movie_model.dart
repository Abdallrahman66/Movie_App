class WatchListMovieModel {
  const WatchListMovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final String overview;

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

  factory WatchListMovieModel.fromMap(Map<dynamic, dynamic> map) {
    return WatchListMovieModel(
      id: (map['id'] as num).toInt(),
      title: map['title'] as String? ?? '',
      posterPath: map['posterPath'] as String? ?? '',
      voteAverage: (map['voteAverage'] as num?)?.toDouble() ?? 0,
      releaseDate: map['releaseDate'] as String? ?? '',
      overview: map['overview'] as String? ?? '',
    );
  }
}
