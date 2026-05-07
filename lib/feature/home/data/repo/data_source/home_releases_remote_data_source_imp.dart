
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/api/home_releases_api.dart';
import 'package:movie_app/feature/home/data/mapper/releases_movie_mapper.dart';
import 'package:movie_app/feature/home/data/model/releases_movie_dto.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';
import 'package:movie_app/feature/home/domain/repo/data_source/releases_data_source_interface.dart';

@Injectable(as: ReleasesDataSourceInterface)
class HomeReleasesRemoteDataSourceImp
    implements ReleasesDataSourceInterface {
  HomeReleasesRemoteDataSourceImp(this._api);
  final HomeReleasesApi _api;

  @override
  Future<ResultApi<HomeMovieEntity>> getReleasesMovie() async {
    final result = await _api.getReleasesMovie();

    switch (result) {

      case SuccessApi<ReleasesMovieDto>():
        final dto = result.data;
        return SuccessApi(dto.toEntity());
        
      case ErrorApi<ReleasesMovieDto>():
        return ErrorApi<HomeMovieEntity>(result.errorMassage);
    }
  }
}
