import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/recommended_movie_entity.dart';
import 'package:movie_app/feature/home/domain/use_case/get_recommended_movie_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._getRecommendedMovieUseCase) : super(HomeInitial());
  final GetRecommendedMovieUseCase _getRecommendedMovieUseCase;

  Future<void> getRecommendedMovie() async {
    emit(HomeLoading());
    final result = await _getRecommendedMovieUseCase.invoke();

    switch (result) {
      case SuccessApi<RecommendedMovieEntity>():
        emit(HomeSuccesses(result.data));
      case ErrorApi<RecommendedMovieEntity>():
        emit(HomeError(result.errorMassage));
    }
  }
}
