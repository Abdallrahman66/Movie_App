import 'package:movie_app/core/network/result_api.dart';

import '../entities/movie_entity.dart';
import '../repo/search_repository.dart';

class SearchMoviesUseCase {
  SearchMoviesUseCase(this.repository);
  final SearchRepository repository;

  Future<ResultApi<List<MovieEntity>>> invoke(String query) {
    return repository.searchMovies(query);
  }
}
