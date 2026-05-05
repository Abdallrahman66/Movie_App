// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccesses extends HomeState {
  HomeSuccesses(this.recommendedMovieEntity);
  final RecommendedMovieEntity recommendedMovieEntity;
}

class HomeError extends HomeState {
  HomeError(this.messageError);
  final String messageError;
}
