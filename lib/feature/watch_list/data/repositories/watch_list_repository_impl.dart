import '../../domain/repositories/watch_list_repository.dart';
import '../data_sources/watch_list_local_data_source.dart';
import '../models/watch_list_movie_model.dart';

class WatchListRepositoryImpl implements WatchListRepository {
  WatchListRepositoryImpl(this._localDataSource);

  final WatchListLocalDataSource _localDataSource;

  @override
  Future<List<WatchListMovieModel>> getMovies() {
    return _localDataSource.getMovies();
  }

  @override
  Future<WatchListMovieModel?> getMovie(int movieId) {
    return _localDataSource.getMovie(movieId);
  }

  @override
  Future<bool> containsMovie(int movieId) {
    return _localDataSource.containsMovie(movieId);
  }

  @override
  Future<void> saveMovie(WatchListMovieModel movie) {
    return _localDataSource.saveMovie(movie);
  }

  @override
  Future<void> removeMovie(int movieId) {
    return _localDataSource.removeMovie(movieId);
  }
}
