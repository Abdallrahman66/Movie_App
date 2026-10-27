import '../../data/models/watch_list_movie_model.dart';
import '../repositories/watch_list_repository.dart';

class GetWatchListUseCase {
  GetWatchListUseCase(this._repository);

  final WatchListRepository _repository;

  Future<List<WatchListMovieModel>> call() {
    return _repository.getMovies();
  }
}
