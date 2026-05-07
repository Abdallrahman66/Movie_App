class HomeMovieEntity {
  HomeMovieEntity({required this.results});

  final List<MovieItemEntity> results;
}

class MovieItemEntity {
  MovieItemEntity({required this.id, required this.posterPath});

  final int id;
  final String posterPath;
  
}
