import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';

abstract interface class DetailsRepository {
  Future<ResultApi<DetailsEntity>> getDetails();
  Future<ResultApi<SimilarEntity>> getSimilar();
}
