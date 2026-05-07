import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

import 'package:movie_app/feature/home/domain/repo/repository/popolure_repository_interface.dart';

@injectable
class GetPopolureMovieUseCase {
  GetPopolureMovieUseCase(this._repo);
  final PopolureRepositoryInterface _repo;
  Future<ResultApi<HomeMovieEntity>> invoke() =>
      _repo.getPopolureMovie();
}
