
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';
import '../../../domain/use_case/search_movies_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.useCase) : super(SearchInitial());

  final SearchMoviesUseCase useCase;

  int _requestId = 0;

  Future<void> searchMovies(String query) async {
    final normalizedQuery = query.trim();

    if (normalizedQuery.isEmpty) {
      clearSearch();
      return;
    }

    final currentRequestId = ++_requestId;

    emit(SearchLoading());

    try {
      final result = await useCase.invoke(normalizedQuery);

      if (isClosed || currentRequestId != _requestId) {
        return;
      }

      switch (result) {
        case SuccessApi<List<MovieEntity>>():
          final movies = result.data;

          if (movies.isEmpty) {
            emit(SearchEmpty());
          } else {
            emit(SearchSuccess(movies, normalizedQuery));
          }

        case ErrorApi<List<MovieEntity>>():
          emit(SearchError(result.errorMassage));
      }
    } catch (error) {
      if (isClosed || currentRequestId != _requestId) {
        return;
      }

      emit(SearchError(error.toString()));
    }
  }

  void clearSearch() {

    _requestId++;

    emit(SearchInitial());
  }
}
