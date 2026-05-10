import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/search/domain/entities/movie_entity.dart';


abstract interface class SearchRepository {
  Future<ResultApi<List<MovieEntity>>> searchMovies(
    String query,
  );
}