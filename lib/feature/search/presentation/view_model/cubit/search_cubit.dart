import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';

import 'package:movie_app/core/network/result_api.dart';

import '../../../domain/use_case/search_movies_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.useCase) : super(SearchInitial());
  final SearchMoviesUseCase useCase;

  Future<void> searchMovies(String query) async {
    final result = await useCase.invoke(query);
    emit(SearchLoading());


    switch (result) {
      case SuccessApi():
        final movies = result.data
            .where(
              (movie) =>
                  movie.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

        if (movies.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchSuccess(movies, query));
        }

      case ErrorApi():
        emit(SearchError(result.errorMassage));
    }
  }
}
