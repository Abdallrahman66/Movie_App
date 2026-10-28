import '../entities/watch_list_movie_entity.dart';
import '../repositories/watch_list_repository.dart';

class GetWatchListUseCase {
  const GetWatchListUseCase(this._repository);

  final WatchListRepository _repository;

  Future<List<WatchListMovieEntity>> call() {
    return _repository.getMovies();
  }
}
