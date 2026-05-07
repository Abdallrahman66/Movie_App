import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/model/recommended_movie_dto.dart';

@singleton
class HomeRecommendedApi {
  Future<ResultApi<RecommendedMovieDto>> getRecommendedMovie() async {
    try {
      var url = Uri.https("api.themoviedb.org", "/3/movie/top_rated", {
        "api_key": "9d7f94be913eddf2db40e317d2f12f36",
      });

      final response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = RecommendedMovieDto.fromJson(json);

        return SuccessApi<RecommendedMovieDto>(dto);
      } else {
        final json = jsonDecode(response.body);

        String message = json["status_message"] ?? "Server error";

        switch (response.statusCode) {
          case 401:
            message = "Unauthorized (API key issue)";
            break;
          case 404:
            message = "Data not found";
            break;
          case 500:
            message = "Server crashed";
            break;
        }

        return ErrorApi<RecommendedMovieDto>(message);
      }
    } on http.ClientException {
      return ErrorApi<RecommendedMovieDto>("No internet connection");
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        return ErrorApi<RecommendedMovieDto>("Request timeout, try again");
      }
      return ErrorApi<RecommendedMovieDto>("Unexpected error: ${e.toString()}");
    }
  }
}
