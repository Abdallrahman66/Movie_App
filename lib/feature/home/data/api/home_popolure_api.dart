import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/home/data/model/popolure_movie_dto.dart';

@singleton
class HomePopularApi {
  Future<ResultApi<PopolureMovieDto>> getPopularMovie() async {
    try {
     
      var url = Uri.https("api.themoviedb.org", "/3/movie/popular", {
        "api_key": "9d7f94be913eddf2db40e317d2f12f36",
      });

      final response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = PopolureMovieDto.fromJson(json);

        return SuccessApi<PopolureMovieDto>(dto);
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

        return ErrorApi<PopolureMovieDto>(message);
      }
    } on http.ClientException {
      return ErrorApi<PopolureMovieDto>("No internet connection");
    } catch (e) {
      if (e.toString().contains("TimeoutException")) {
        return ErrorApi<PopolureMovieDto>("Request timeout, try again");
      }
      return ErrorApi<PopolureMovieDto>("Unexpected error: ${e.toString()}");
    }
  }
}
