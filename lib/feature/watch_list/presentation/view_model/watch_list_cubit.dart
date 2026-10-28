import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/watch_list_movie_entity.dart';
import '../../domain/use_cases/get_watch_list_use_case.dart';
import '../../domain/use_cases/remove_watch_list_movie_use_case.dart';
import '../../domain/use_cases/toggle_watch_list_use_case.dart';
import 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit({
    required GetWatchListUseCase getWatchList,
    required ToggleWatchListUseCase toggleWatchList,
    required RemoveWatchListMovieUseCase removeWatchListMovie,
  }) : _getWatchList = getWatchList,
       _toggleWatchList = toggleWatchList,
       _removeWatchListMovie = removeWatchListMovie,
       super(const WatchListInitial());

  final GetWatchListUseCase _getWatchList;
  final ToggleWatchListUseCase _toggleWatchList;
  final RemoveWatchListMovieUseCase _removeWatchListMovie;

  final Set<int> _pendingMovieIds = <int>{};

  List<WatchListMovieEntity> _movies = <WatchListMovieEntity>[];

  int _loadRequestId = 0;

  List<WatchListMovieEntity> get movies => List.unmodifiable(_movies);

  Future<void> loadMovies() async {
    final requestId = ++_loadRequestId;

    if (_movies.isEmpty) {
      emit(const WatchListLoading());
    }

    try {
      final loadedMovies = await _getWatchList();

      if (isClosed ||
          requestId != _loadRequestId ||
          _pendingMovieIds.isNotEmpty) {
        return;
      }

      _movies = List.unmodifiable(loadedMovies);

      emit(WatchListLoaded(_movies));
    } catch (_) {
      if (isClosed || requestId != _loadRequestId) {
        return;
      }

      if (_movies.isNotEmpty) {
        emit(WatchListLoaded(_movies));
      } else {
        emit(const WatchListError('Unable to load your watch list.'));
      }
    }
  }

  Future<bool> toggleMovie(WatchListMovieEntity movie) async {
    if (_pendingMovieIds.contains(movie.id)) {
      return _movies.any((item) => item.id == movie.id);
    }

    _pendingMovieIds.add(movie.id);
    _loadRequestId++;

    try {
      final saved = await _toggleWatchList(movie);

      if (isClosed) return saved;

      if (saved) {
        _movies = List.unmodifiable([
          ..._movies.where((item) => item.id != movie.id),
          movie,
        ]);
      } else {
        _movies = List.unmodifiable(
          _movies.where((item) => item.id != movie.id),
        );
      }

      emit(WatchListLoaded(_movies));

      return saved;
    } finally {
      _pendingMovieIds.remove(movie.id);
    }
  }

  Future<void> removeMovie(int movieId) async {
    if (_pendingMovieIds.contains(movieId)) {
      return;
    }

    _pendingMovieIds.add(movieId);
    _loadRequestId++;

    try {
      await _removeWatchListMovie(movieId);

      if (isClosed) return;

      _movies = List.unmodifiable(
        _movies.where((movie) => movie.id != movieId),
      );

      emit(WatchListLoaded(_movies));
    } finally {
      _pendingMovieIds.remove(movieId);
    }
  }

  bool isSaved(int movieId) {
    return _movies.any((movie) => movie.id == movieId);
  }
}
