import 'package:movie_app/feature/watch_list/domain/entities/watch_list_entity.dart';
import 'package:movie_app/feature/watch_list/domain/repo/watch_list_repo.dart';

class AddMovieUseCase {
  AddMovieUseCase(this._repo);
  final WatchListRepo _repo;

  Future<void> call(WatchListEntity movie) async {
    await _repo.addMovie(movie);
  }
}
