import '../repositories/watch_list_repository.dart';

class RemoveWatchListMovieUseCase {
  const RemoveWatchListMovieUseCase(this._repository);

  final WatchListRepository _repository;

  Future<void> call(int movieId) {
    return _repository.removeMovie(movieId);
  }
}
