import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/repo/data_source/details_data_source_imp.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';
import 'package:movie_app/feature/details/domain/repo/data_source/details_data_source.dart';
import 'package:movie_app/feature/details/domain/repo/repository/details_repository.dart';

class DetailsRepositoryImp implements DetailsRepository {
  DetailsRepositoryImp(this._dataSource);
  final DetailsDataSource _dataSource;
  @override
  Future<ResultApi<DetailsEntity>> getDetails(int id) async {
    final result = await _dataSource.getDetails(id);
    switch (result) {
      case SuccessApi<DetailsEntity>():
        final detailsEntity = result.data;
        return SuccessApi<DetailsEntity>(detailsEntity);
      case ErrorApi<DetailsEntity>():
        return ErrorApi<DetailsEntity>(result.errorMassage);
    }
  }

  @override
  Future<ResultApi<List<SimilarEntity>>> getSimilar(int id) async {
    final result = await _dataSource.getSimilar(id);
    switch (result) {
      case SuccessApi<List<SimilarEntity>>():
        final List<SimilarEntity> similarList = result.data;
        return SuccessApi<List<SimilarEntity>>(similarList);
      case ErrorApi<List<SimilarEntity>>():
        return ErrorApi<List<SimilarEntity>>(result.errorMassage);
    }
  }
}

DetailsRepository detailsRepositoryImpIngectable() =>
    DetailsRepositoryImp(detailsDataSourceImpInjectable());
