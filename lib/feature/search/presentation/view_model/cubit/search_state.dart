import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<MovieEntity> movies;

  SearchSuccess(this.movies);
}

final class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}