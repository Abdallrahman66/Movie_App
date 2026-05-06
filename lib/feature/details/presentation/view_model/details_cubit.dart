import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';
import 'package:movie_app/feature/details/domain/use_case/get_details_use_case.dart';
import 'package:movie_app/feature/details/domain/use_case/get_similar_use_case.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._details, this._similar, this.id) : super(DetailsInitial());
  final GetDetailsUseCase _details;
  final GetSimilarUseCase _similar;

  late final DetailsEntity movie;
  late final List<SimilarEntity> similarMovies;

  int id;
  Future<void> getDetails() async {
    emit(DetailsLoadingState());
    final result = await _details.invoke(id);
    switch (result) {
      case SuccessApi<DetailsEntity>():
        movie = result.data;
        emit(DetailsSuccessState());
      case ErrorApi<DetailsEntity>():
        emit(DetailsErrorState(result.errorMassage));
    }
  }

  Future<void> getSimilar() async {
    emit(SimilarLoadingState());
    final result = await _similar.invoke(id);
    switch (result) {
      case SuccessApi<List<SimilarEntity>>():
        similarMovies = result.data;
        emit(SimilarSuccessState());
      case ErrorApi<List<SimilarEntity>>():
        emit(SimilarErrorState(result.errorMassage));
    }
  }

  Future<void> getData(int id) async {
    this.id = id;
    await Future.wait([getDetails(), getSimilar()]);
  }
}

//  Future<ResultApi<List<SimilarEntity>>>
