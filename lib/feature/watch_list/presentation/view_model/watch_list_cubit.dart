import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/watch_list/domain/entities/watch_list_entity.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/add_movie_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/get_all_movies_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/is_movie_saved_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_case/remove_movie_use_case.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit({
    required this.addMovieUseCase,
    required this.removeMovieUseCase,
    required this.getAllMoviesUseCase,
    required this.isMovieSavedUseCase,
  }) : super(WatchListInitial());

  final AddMovieUseCase addMovieUseCase;
  final RemoveMovieUseCase removeMovieUseCase;
  final GetAllMoviesUseCase getAllMoviesUseCase;
  final IsMovieSavedUseCase isMovieSavedUseCase;

  void loadMovies() {
    final movies = getAllMoviesUseCase();
    if (movies.isEmpty) {
      emit(WatchListEmpty());
    } else {
      emit(WatchListLoaded(movies));
    }
  }

  Future<void> toggleMovie(WatchListEntity movie) async {
    if (isMovieSavedUseCase(movie.id)) {
      await removeMovieUseCase(movie.id);
    } else {
      await addMovieUseCase(movie);
    }
    loadMovies();
  }

  bool isSaved(int id) => isMovieSavedUseCase(id);
}
