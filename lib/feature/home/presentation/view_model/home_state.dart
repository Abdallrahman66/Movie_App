
part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeRecommendedSuccesses extends HomeState {
  HomeRecommendedSuccesses(this.recommendedMovieEntity);
  final RecommendedMovieEntity recommendedMovieEntity;
}

class HomePopolureSuccesses extends HomeState {
  HomePopolureSuccesses(this.popolureMovieEntity);
  final PopolureMovieEntity popolureMovieEntity;
}
class HomeReleasesSuccesses extends HomeState {
  HomeReleasesSuccesses(this.releasesMovieEntity);
  final ReleasesMovieEntity releasesMovieEntity;
}


class HomeRecommendedError extends HomeState {
  HomeRecommendedError(this.messageError);
  final String messageError;
}

class HomePopolureError extends HomeState {
  HomePopolureError(this.messageError);
  final String messageError;
}

class HomeReleasesError extends HomeState {
  HomeReleasesError(this.messageError);
  final String messageError;
}
