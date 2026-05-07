import 'package:movie_app/core/network/result_api.dart';

import 'package:movie_app/feature/home/domain/entity/releases_movie_entity.dart';

abstract interface class ReleasesRepositoryInterface {
  Future<ResultApi<ReleasesMovieEntity>> getReleasesMovie();
}
