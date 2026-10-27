import '../../data/models/watch_list_movie_model.dart';

abstract interface class WatchListRepository {
  Future<List<WatchListMovieModel>> getMovies();

  Future<WatchListMovieModel?> getMovie(int movieId);

  Future<bool> containsMovie(int movieId);

  Future<void> saveMovie(WatchListMovieModel movie);

  Future<void> removeMovie(int movieId);
}
