import 'package:movie_app/feature/watch_list/domain/repo/watch_list_repo.dart';

class RemoveMovieUseCase {
  RemoveMovieUseCase(this._repo);
  final WatchListRepo _repo;

  Future<void> call(int id) async {
    await _repo.removeMovie(id);
  }
}
