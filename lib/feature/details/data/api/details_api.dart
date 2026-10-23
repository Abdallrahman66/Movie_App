import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/result_api.dart';
import 'package:movie_app/feature/details/data/model/details_dto.dart';
import 'package:movie_app/feature/details/data/model/similar_dto.dart';

class DetailsApi {
  static const String _apiKey = '9d7f94be913eddf2db40e317d2f12f36';

  Future<ResultApi<DetailsDto>> getDetails(int id) async {
    try {
      final uri = Uri.https('api.themoviedb.org', '/3/movie/$id', {
        'api_key': _apiKey,
        'append_to_response': 'credits',
      });

      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      final body = _decodeBody(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return SuccessApi(DetailsDto.fromJson(body));
      }

      return ErrorApi(_errorMessage(body, response.statusCode));
    } on TimeoutException {
      return ErrorApi('The request timed out. Please try again.');
    } on http.ClientException {
      return ErrorApi(
        'Unable to connect. Please check your internet connection.',
      );
    } on FormatException {
      return ErrorApi('The server returned an invalid response.');
    } catch (_) {
      return ErrorApi('Something went wrong while loading movie details.');
    }
  }

  Future<ResultApi<SimilarDto>> getSimilar(int id) async {
    try {
      final uri = Uri.https('api.themoviedb.org', '/3/movie/$id/similar', {
        'api_key': _apiKey,
      });

      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      final body = _decodeBody(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return SuccessApi(SimilarDto.fromJson(body));
      }

      return ErrorApi(_errorMessage(body, response.statusCode));
    } on TimeoutException {
      return ErrorApi('The request timed out. Please try again.');
    } on http.ClientException {
      return ErrorApi(
        'Unable to connect. Please check your internet connection.',
      );
    } on FormatException {
      return ErrorApi('The server returned an invalid response.');
    } catch (_) {
      return ErrorApi('Something went wrong while loading similar movies.');
    }
  }

  Map<String, dynamic> _decodeBody(String body) {
    final decoded = jsonDecode(body);

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Expected a JSON object.');
    }

    return decoded;
  }

  String _errorMessage(Map<String, dynamic> body, int statusCode) {
    final message = body['status_message'];

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    switch (statusCode) {
      case 401:
        return 'TMDB rejected the API key (401).';

      case 404:
        return 'Movie not found (404).';

      default:
        return 'Unable to load data (HTTP $statusCode).';
    }
  }
}
