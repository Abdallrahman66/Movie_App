import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';
import 'package:movie_app/core/network/result_api.dart';
import '../../../domain/use_case/search_movies_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchMoviesUseCase useCase;

  SearchCubit(this.useCase) : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    emit(SearchLoading());

    final result = await useCase.call(query);

    switch (result) {
      case SuccessApi():
        emit(SearchSuccess(result.data));

      case ErrorApi():
        emit(SearchError(result.errorMassage));
    }
  }
}
