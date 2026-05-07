import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class HomeSearchApi {
  Future<MovieModel> searchMovies(String query) async {
    final uri = Uri.https("api.themoviedb.org", "/3/search/movie", {
      "query": query,
      "api_key": "9d7f94be913eddf2db40e317d2f12f36",
    });

    final response = await http.get(uri);

    final json = jsonDecode(response.body);

    return MovieModel.fromJson(json);
  }
}
