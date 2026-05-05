import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/domain/entities/similar_entity.dart';
import 'package:movie_app/feature/details/domain/repo/repository/details_repository.dart';

class GetSimilarUseCase {
  GetSimilarUseCase(this._repo);

  final DetailsRepository _repo;

  Future<ResultApi<SimilarEntity>> invoke() => _repo.getSimilar();
}

// GetNewsUseCase getNewsUseCaseInject() =>
//     GetNewsUseCase(homeRepositoryinjectable());
