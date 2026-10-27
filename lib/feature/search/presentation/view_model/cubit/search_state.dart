
part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchSuccess extends SearchState {
  SearchSuccess(this.movies, this.query);

  final List<MovieEntity> movies;
  final String query;
}

class SearchError extends SearchState {
  SearchError(this.error);

  final String error;
}
