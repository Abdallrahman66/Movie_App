import '../entities/watch_list_movie_entity.dart';

abstract interface class WatchListRepository {
  Future<List<WatchListMovieEntity>> getMovies();

  Future<WatchListMovieEntity?> getMovie(int movieId);

  Future<bool> containsMovie(int movieId);

  Future<void> saveMovie(WatchListMovieEntity movie);

  Future<void> removeMovie(int movieId);
}
