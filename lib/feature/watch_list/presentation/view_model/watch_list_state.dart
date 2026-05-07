part of 'watch_list_cubit.dart';

abstract class WatchListState {}

class WatchListInitial extends WatchListState {}

class WatchListEmpty extends WatchListState {}

class WatchListLoaded extends WatchListState {
  WatchListLoaded(this.movies);
  final List<WatchListEntity> movies;
}
