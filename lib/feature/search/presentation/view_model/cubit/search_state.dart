part of 'search_cubit.dart';

abstract class SearchState {}

 class SearchInitial extends SearchState {}

 class SearchLoading extends SearchState {}

 class SearchEmpty extends SearchState {}

 class SearchSuccess extends SearchState {
  final List<MovieEntity> movies;

  SearchSuccess(this.movies);
}

 class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}
