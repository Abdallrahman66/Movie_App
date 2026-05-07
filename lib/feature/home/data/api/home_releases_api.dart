import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/model/releases_movie_dto.dart';

@singleton
class HomeReleasesApi {
  Future<ResultApi<ReleasesMovieDto>> getReleasesMovie() async {
    try {
      var url = Uri.https("api.themoviedb.org", "/3/movie/upcoming", {
        "api_key": "9d7f94be913eddf2db40e317d2f12f36",
      });

      final response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = ReleasesMovieDto.fromJson(json);

        return SuccessApi<ReleasesMovieDto>(dto);
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
        return ErrorApi<ReleasesMovieDto>(message);
      }
    } on http.ClientException {
      return ErrorApi<ReleasesMovieDto>("No internet connection");
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        return ErrorApi<ReleasesMovieDto>("Request timeout, try again");
      }
      return ErrorApi<ReleasesMovieDto>("Unexpected error: ${e.toString()}");
    }
  }
}
