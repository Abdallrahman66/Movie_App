import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/watch_list_movie_model.dart';
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

  final Set<int> _pendingMovieIds = {};

  List<WatchListMovieModel> _movies = [];

  List<WatchListMovieModel> get movies => List.unmodifiable(_movies);

  Future<void> loadMovies() async {
    emit(const WatchListLoading());

    try {
      _movies = await _getWatchList();

      if (!isClosed) {
        emit(WatchListLoaded(List.unmodifiable(_movies)));
      }
    } catch (error) {
      if (!isClosed) {
        emit(WatchListError('Unable to load your watch list.'));
      }
    }
  }

  Future<bool> toggleMovie(WatchListMovieModel movie) async {
    if (_pendingMovieIds.contains(movie.id)) {
      return _movies.any((item) => item.id == movie.id);
    }

    _pendingMovieIds.add(movie.id);

    try {
      final saved = await _toggleWatchList(movie);

      await _refreshMovies();

      return saved;
    } catch (_) {
      rethrow;
    } finally {
      _pendingMovieIds.remove(movie.id);
    }
  }

  Future<void> removeMovie(int movieId) async {
    if (_pendingMovieIds.contains(movieId)) {
      return;
    }

    _pendingMovieIds.add(movieId);

    try {
      await _removeWatchListMovie(movieId);
      await _refreshMovies();
    } finally {
      _pendingMovieIds.remove(movieId);
    }
  }

  Future<bool> isSaved(int movieId) async {
    return _movies.any((movie) => movie.id == movieId);
  }

  Future<void> _refreshMovies() async {
    _movies = await _getWatchList();

    if (!isClosed) {
      emit(WatchListLoaded(List.unmodifiable(_movies)));
    }
  }
}
