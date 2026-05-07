import 'package:http/http.dart' as http;

import 'package:movie_app/core/network/result_api.dart';

import '../../domain/entities/movie_entity.dart';
import '../../domain/repo/search_repository.dart';

import '../api/home_search_api.dart';

class SearchRepositoryImpl implements SearchRepository {
  final HomeSearchApi remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<ResultApi<List<MovieEntity>>> searchMovies(String query) async {
    try {
      final response = await remoteDataSource.searchMovies(query);

      final movies = response.results?.map((e) => e.toEntity()).toList() ?? [];

      return SuccessApi(movies);
    } on http.ClientException {
      return ErrorApi("Please Check Your Internet Connection");
    } catch (e) {
      return ErrorApi(e.toString());
    }
  }
}
