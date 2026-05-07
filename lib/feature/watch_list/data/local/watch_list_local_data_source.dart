import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/feature/watch_list/domain/entities/watch_list_entity.dart';

class WatchListLocalDataSource {
  static const String _boxName = 'watchlist';

  Box<WatchListEntity> get _box => Hive.box<WatchListEntity>(_boxName);

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WatchListEntityAdapter());
    await Hive.openBox<WatchListEntity>(_boxName);
  }

  Future<void> addMovie(WatchListEntity movie) async {
    await _box.put(movie.id, movie);
  }

  Future<void> removeMovie(int id) async {
    await _box.delete(id);
  }

  bool isMovieSaved(int id) {
    return _box.containsKey(id);
  }

  List<WatchListEntity> getAllMovies() {
    return _box.values.toList();
  }
}
