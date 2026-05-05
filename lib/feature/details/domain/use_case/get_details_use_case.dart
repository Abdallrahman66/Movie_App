// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/domain/entities/details_entity.dart';
import 'package:movie_app/feature/details/domain/repo/repository/details_repository.dart';

class GetDetailsUseCase {
  GetDetailsUseCase(this._repo);

  final DetailsRepository _repo;

  Future<ResultApi<DetailsEntity>> invoke() => _repo.getDetails();
}

// GetNewsUseCase getNewsUseCaseInject() =>
//     GetNewsUseCase(homeRepositoryinjectable());
