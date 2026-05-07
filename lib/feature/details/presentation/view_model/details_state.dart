part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsSuccessState extends DetailsState {}

class DetailsErrorState extends DetailsState {
  DetailsErrorState(this.error);
  final String error;
}

class SimilarLoadingState extends DetailsState {}

class SimilarSuccessState extends DetailsState {}

class SimilarErrorState extends DetailsState {
  SimilarErrorState(this.error);
  final String error;
}
