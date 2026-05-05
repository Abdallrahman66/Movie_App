import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/domain/entity/recommended_movie_entity.dart';

abstract interface class RecommendedRepositoryInterface {
    Future<ResultApi<RecommendedMovieEntity>> getRecommendedMovie();
}
