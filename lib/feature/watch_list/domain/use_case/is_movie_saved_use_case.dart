import 'package:movie_app/feature/watch_list/domain/repo/watch_list_repo.dart';

class IsMovieSavedUseCase {
  IsMovieSavedUseCase(this._repo);
  final WatchListRepo _repo;

  bool call(int id) {
    return _repo.isMovieSaved(id);
  }
}
