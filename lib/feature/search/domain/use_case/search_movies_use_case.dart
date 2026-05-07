import 'package:movie_app/core/network/result_api.dart';

import '../entities/movie_entity.dart';
import '../repo/search_repository.dart';

class SearchMoviesUseCase {
  final SearchRepository repository;

  SearchMoviesUseCase(this.repository);

  Future<ResultApi<List<MovieEntity>>> call(
    String query,
  ) {
    return repository.searchMovies(query);
  }
}