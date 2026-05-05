import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/api/details_api.dart';
import 'package:movie_app/feature/details/data/model/details_dto.dart';
import 'package:movie_app/feature/details/data/model/similar_dto.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';
import 'package:movie_app/feature/details/domain/repo/data_source/details_data_source.dart';

class DetailsDataSourceImp implements DetailsDataSource {
  DetailsDataSourceImp(this._api);
  final DetailsApi _api;
  @override
  Future<ResultApi<DetailsEntity>> getDetails(int id) async {
    final result = await _api.getDetails(id);
    switch (result) {
      case SuccessApi<DetailsDto>():
        final detailsDto = result.data;
        return SuccessApi<DetailsEntity>(detailsDto.toEntity());
      case ErrorApi<DetailsDto>():
        return ErrorApi<DetailsEntity>(result.errorMassage);
    }
  }

  @override
  Future<ResultApi<List<SimilarEntity>>> getSimilar(int id) async {
    final result = await _api.getSimilar(id);
    switch (result) {
      case SuccessApi<SimilarDto>():
        final similarDto = result.data;
        return SuccessApi<List<SimilarEntity>>(similarDto.toEntity());
      case ErrorApi<SimilarDto>():
        return ErrorApi<List<SimilarEntity>>(result.errorMassage);
    }
  }
}

DetailsDataSource detailsDataSourceImpInjectable() =>
    DetailsDataSourceImp(DetailsApi());
