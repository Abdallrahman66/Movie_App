import 'package:movie_app/feature/watch_list/domain/entities/watch_list_entity.dart';
import 'package:movie_app/feature/watch_list/domain/repo/watch_list_repo.dart';

class GetAllMoviesUseCase {
  GetAllMoviesUseCase(this._repo);
  final WatchListRepo _repo;

  List<WatchListEntity> call() {
    return _repo.getAllMovies();
  }
}
