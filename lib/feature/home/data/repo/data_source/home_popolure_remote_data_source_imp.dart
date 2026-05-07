import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/api/home_popolure_api.dart';
import 'package:movie_app/feature/home/data/mapper/popolure_movie_mapper.dart';

import 'package:movie_app/feature/home/data/model/popolure_movie_dto.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

import 'package:movie_app/feature/home/domain/repo/data_source/popolure_data_source_interface.dart';

@Injectable(as: PopolureDataSourceInterface)
class HomePopolureRemoteDataSourceImp implements PopolureDataSourceInterface {
  HomePopolureRemoteDataSourceImp(this._api);
  final HomePopularApi _api;

  @override
  Future<ResultApi<HomeMovieEntity>> getPopolureMovie() async {
    final result = await _api.getPopularMovie();
    switch (result) {
      case SuccessApi<PopolureMovieDto>():
        final dto = result.data;
        return SuccessApi(dto.toEntity());
      case ErrorApi<PopolureMovieDto>():
        return ErrorApi<HomeMovieEntity>(result.errorMassage);
    }
  }
}
