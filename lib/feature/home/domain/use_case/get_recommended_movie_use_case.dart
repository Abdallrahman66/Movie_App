import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';

import 'package:movie_app/feature/home/domain/entity/recommended_movie_entity.dart';
import 'package:movie_app/feature/home/domain/repo/repository/recommended_repository_interface.dart';

@injectable
class GetRecommendedMovieUseCase {
  GetRecommendedMovieUseCase(this._repo);

  final RecommendedRepositoryInterface _repo;

  Future<ResultApi<RecommendedMovieEntity>> invoke() =>
      _repo.getRecommendedMovie();
}

// GetRecommendedMovieUseCase getRecommendedMovieUseCaseInjectable() =>
//     GetRecommendedMovieUseCase(
//       recommendedRepositoryInjectable()
//        );
