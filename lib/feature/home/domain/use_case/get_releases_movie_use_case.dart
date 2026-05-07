import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';

import 'package:movie_app/feature/home/domain/repo/repository/releases_repository_interface.dart';

@injectable
class GetReleasesMovieUseCase {
  GetReleasesMovieUseCase(this._repo);

  final ReleasesRepositoryInterface _repo;

  Future<ResultApi<HomeMovieEntity>> invoke() => _repo.getReleasesMovie();
}
