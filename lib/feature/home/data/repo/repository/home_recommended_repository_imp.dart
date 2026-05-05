import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';


import 'package:movie_app/feature/home/domain/entity/recommended_movie_entity.dart';
import 'package:movie_app/feature/home/domain/repo/data_source/recommended_data_source_interface.dart';
import 'package:movie_app/feature/home/domain/repo/repository/recommended_repository_interface.dart';

@LazySingleton(as: RecommendedRepositoryInterface)
class HomeRecommendedRepositoryImp implements RecommendedRepositoryInterface {
  HomeRecommendedRepositoryImp(this._dataSource);
  final RecommendedDataSourceInterface _dataSource;

  @override
  Future<ResultApi<RecommendedMovieEntity>> getRecommendedMovie() =>
      _dataSource.getRecommendedMovie();
}

// RecommendedDataSourceInterface recommendedRepositoryInjectable() =>
//     HomeRecommendedRepositoryImp(recommendedDataSourceInjectable());
