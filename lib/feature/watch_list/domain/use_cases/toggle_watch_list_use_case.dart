import '../../data/models/watch_list_movie_model.dart';
import '../repositories/watch_list_repository.dart';

class ToggleWatchListUseCase {
  ToggleWatchListUseCase(this._repository);

  final WatchListRepository _repository;

  Future<bool> call(WatchListMovieModel movie) async {
    final exists = await _repository.containsMovie(movie.id);

    if (exists) {
      await _repository.removeMovie(movie.id);
      return false;
    }

    await _repository.saveMovie(movie);
    return true;
  }
}
