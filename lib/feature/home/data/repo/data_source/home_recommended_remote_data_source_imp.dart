import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/api/home_recommended_api.dart';
import 'package:movie_app/feature/home/data/mapper/recommended_movie_maper.dart';
import 'package:movie_app/feature/home/data/model/recommended_movie_dto.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

import 'package:movie_app/feature/home/domain/repo/data_source/recommended_data_source_interface.dart';

@Injectable(as: RecommendedDataSourceInterface)

class HomeRecommendedRemoteDataSourceImp
    implements RecommendedDataSourceInterface {
      
  HomeRecommendedRemoteDataSourceImp(this._api);
  final HomeRecommendedApi _api;

  @override
  Future<ResultApi<HomeMovieEntity>> getRecommendedMovie() async {
    final result = await _api.getRecommendedMovie();

    switch (result) {
      case SuccessApi<RecommendedMovieDto>():
        final dto = result.data;
        return SuccessApi(dto.toEntity());
      case ErrorApi<RecommendedMovieDto>():
        return ErrorApi<HomeMovieEntity>(result.errorMassage);
    }
  }
}
