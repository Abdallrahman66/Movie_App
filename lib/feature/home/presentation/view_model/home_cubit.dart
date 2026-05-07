import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/popular_movie_entity.dart';
import 'package:movie_app/feature/home/domain/entity/recommended_movie_entity.dart';
import 'package:movie_app/feature/home/domain/entity/releases_movie_entity.dart';
import 'package:movie_app/feature/home/domain/use_case/get_popolure_movie_use_case.dart';
import 'package:movie_app/feature/home/domain/use_case/get_recommended_movie_use_case.dart';
import 'package:movie_app/feature/home/domain/use_case/get_releases_movie_use_case.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getRecommendedMovieUseCase,
    this._getPopolureMovieUseCase,
    this._getReleasesMovieUseCase,
  ) : super(HomeInitial());
  final GetRecommendedMovieUseCase _getRecommendedMovieUseCase;
  final GetPopolureMovieUseCase _getPopolureMovieUseCase;
  final GetReleasesMovieUseCase _getReleasesMovieUseCase;

  Future<void> getRecommendedMovie() async {
    emit(HomeLoading());
    final result = await _getRecommendedMovieUseCase.invoke();

    switch (result) {
      case SuccessApi<RecommendedMovieEntity>():
        emit(HomeRecommendedSuccesses(result.data));
      case ErrorApi<RecommendedMovieEntity>():
        emit(HomeRecommendedError(result.errorMassage));
    }
  }

  Future<void> getPopolureMovie() async {
    emit(HomeLoading());
    final result = await _getPopolureMovieUseCase.invoke();

    switch (result) {
      case SuccessApi<PopolureMovieEntity>():
        emit(HomePopolureSuccesses(result.data));
      case ErrorApi<PopolureMovieEntity>():
        emit(HomePopolureError(result.errorMassage));
    }
  }

  Future<void> getReleasesMovie() async {
    emit(HomeLoading());
    final result = await _getReleasesMovieUseCase.invoke();

    switch (result) {
      case SuccessApi<ReleasesMovieEntity>():
        emit(HomeReleasesSuccesses(result.data));
      case ErrorApi<ReleasesMovieEntity>():
        emit(HomeReleasesError(result.errorMassage));
    }
  }
}
