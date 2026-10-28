import '../../domain/entities/watch_list_movie_entity.dart';

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
  WatchListLoaded(List<WatchListMovieEntity> movies)
    : movies = List.unmodifiable(movies);

  final List<WatchListMovieEntity> movies;
}

final class WatchListError extends WatchListState {
  const WatchListError(this.message);

  final String message;
}
