import 'package:hive_ce/hive_ce.dart';

import '../models/watch_list_movie_model.dart';

class WatchListLocalDataSource {
  WatchListLocalDataSource(this._box);

  final Box<dynamic> _box;

  Future<List<WatchListMovieModel>> getMovies() async {
    final movies = <WatchListMovieModel>[];

    for (final value in _box.values) {
      if (value is Map) {
        movies.add(WatchListMovieModel.fromMap(value));
      }
    }

    return movies;
  }

  Future<WatchListMovieModel?> getMovie(int movieId) async {
    final value = _box.get(movieId);

    if (value is! Map) {
      return null;
    }

    return WatchListMovieModel.fromMap(value);
  }

  Future<bool> containsMovie(int movieId) async {
    return _box.containsKey(movieId);
  }

  Future<void> saveMovie(WatchListMovieModel movie) async {
    await _box.put(movie.id, movie.toMap());
  }

  Future<void> removeMovie(int movieId) async {
    await _box.delete(movieId);
  }
}
