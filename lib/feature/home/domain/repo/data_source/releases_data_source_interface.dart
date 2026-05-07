import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/home_movie_entity.dart';



abstract interface class ReleasesDataSourceInterface {
  Future<ResultApi<HomeMovieEntity>> getReleasesMovie();
}
