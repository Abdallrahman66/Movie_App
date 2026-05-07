import 'package:movie_app/feature/watch_list/data/local/watch_list_local_data_source.dart';
import 'package:movie_app/feature/watch_list/domain/entities/watch_list_entity.dart';
import 'package:movie_app/feature/watch_list/domain/repo/watch_list_repo.dart';

class WatchListRepoImp implements WatchListRepo {
  WatchListRepoImp(this._localDataSource);
  final WatchListLocalDataSource _localDataSource;

  @override
  Future<void> addMovie(WatchListEntity movie) async {
    await _localDataSource.addMovie(movie);
  }

  @override
  Future<void> removeMovie(int id) async {
    await _localDataSource.removeMovie(id);
  }

  @override
  bool isMovieSaved(int id) {
    return _localDataSource.isMovieSaved(id);
  }

  @override
  List<WatchListEntity> getAllMovies() {
    return _localDataSource.getAllMovies();
  }
}
