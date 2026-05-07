import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

import 'package:movie_app/feature/home/domain/repo/data_source/releases_data_source_interface.dart';
import 'package:movie_app/feature/home/domain/repo/repository/releases_repository_interface.dart';

@LazySingleton(as: ReleasesRepositoryInterface)
class HomeReleasesRepositoryImp implements ReleasesRepositoryInterface {
  HomeReleasesRepositoryImp(this._dataSource);
  final ReleasesDataSourceInterface _dataSource;

  @override
  Future<ResultApi<HomeMovieEntity>> getReleasesMovie() =>
      _dataSource.getReleasesMovie();
}
