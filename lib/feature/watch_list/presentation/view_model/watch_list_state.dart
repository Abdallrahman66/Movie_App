import '../../data/models/watch_list_movie_model.dart';

sealed class WatchListState {
  const WatchListState();
}

final class WatchListInitial extends WatchListState {
  const WatchListInitial();
}

final class WatchListLoading extends WatchListState {
  const WatchListLoading();
}

final class WatchListLoaded extends WatchListState {
  const WatchListLoaded(this.movies);

  final List<WatchListMovieModel> movies;
}

final class WatchListError extends WatchListState {
  const WatchListError(this.message);

  final String message;
}
