import 'package:movie_app/feature/watch_list/domain/entities/watch_list_entity.dart';

abstract class WatchListRepo {
  Future<void> addMovie(WatchListEntity movie);
  Future<void> removeMovie(int id);
  bool isMovieSaved(int id);
  List<WatchListEntity> getAllMovies();
}
