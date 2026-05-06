import 'dart:convert';
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/model/details_dto.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/feature/details/data/model/similar_dto.dart';

class DetailsApi {
  Future<ResultApi<DetailsDto>> getDetails(int id) async {
    // api.themoviedb.org/3/movie/1419406?api_key=9d7f94be913eddf2db40e317d2f12f36
    try {
      final Uri url = Uri.https("api.themoviedb.org", "/3/movie/$id", {
        'api_key': "9d7f94be913eddf2db40e317d2f12f36",
      });
      final response = await http.get(url);
      if (response.statusCode == 200 && response.statusCode < 300) {
        String responsBody = response.body;
        Map<String, dynamic> json = jsonDecode(responsBody);
        return SuccessApi<DetailsDto>(DetailsDto.fromJson(json));
      } else {
        return ErrorApi("Error on requst of Api");
      }
    } catch (e) {
      return ErrorApi(e.toString());
    }
  }

  Future<ResultApi<SimilarDto>> getSimilar(int id) async {
    // api.themoviedb.org/3/movie/1419406/similar?api_key=9d7f94be913eddf2db40e317d2f12f36
    try {
      final Uri url = Uri.https("api.themoviedb.org", "/3/movie/$id/similar", {
        'api_key': "9d7f94be913eddf2db40e317d2f12f36",
      });
      final response = await http.get(url);
      if (response.statusCode == 200 && response.statusCode < 300) {
        String responsBody = response.body;
        Map<String, dynamic> json = jsonDecode(responsBody);
        return SuccessApi<SimilarDto>(SimilarDto.fromJson(json));
      } else {
        return ErrorApi("Error on requst of Api");
      }
    } catch (e) {
      return ErrorApi(e.toString());
    }
  }
}
