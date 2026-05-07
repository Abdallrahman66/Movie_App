import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/popular_movie_entity.dart';

abstract interface class PopolureRepositoryInterface {
  Future<ResultApi<PopolureMovieEntity>> getPopolureMovie();
}
