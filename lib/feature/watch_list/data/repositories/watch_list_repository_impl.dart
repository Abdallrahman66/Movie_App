import '../../domain/entities/watch_list_movie_entity.dart';
import '../../domain/repositories/watch_list_repository.dart';
import '../data_sources/watch_list_local_data_source.dart';
import '../models/watch_list_movie_model.dart';

class WatchListRepositoryImpl implements WatchListRepository {
  const WatchListRepositoryImpl(this._localDataSource);

  final WatchListLocalDataSource _localDataSource;

  @override
  Future<List<WatchListMovieEntity>> getMovies() async {
    return _localDataSource.getMovies();
  }

  @override
  Future<WatchListMovieEntity?> getMovie(int movieId) async {
    return _localDataSource.getMovie(movieId);
  }

  @override
  Future<bool> containsMovie(int movieId) {
    return _localDataSource.containsMovie(movieId);
  }

  @override
  Future<void> saveMovie(WatchListMovieEntity movie) {
    return _localDataSource.saveMovie(WatchListMovieModel.fromEntity(movie));
  }

  @override
  Future<void> removeMovie(int movieId) {
    return _localDataSource.removeMovie(movieId);
  }
}
