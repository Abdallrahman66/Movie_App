import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/popular_movie_entity.dart';
import 'package:movie_app/feature/home/domain/repo/data_source/popolure_data_source_interface.dart';
import 'package:movie_app/feature/home/domain/repo/repository/popolure_repository_interface.dart';

@LazySingleton(as: PopolureRepositoryInterface)
class HomePopolureRepositoryImp implements PopolureRepositoryInterface {
  HomePopolureRepositoryImp(this._dataSource);
  final PopolureDataSourceInterface _dataSource;

  @override
  Future<ResultApi<PopolureMovieEntity>> getPopolureMovie() =>
      _dataSource.getPopolureMovie();
}
