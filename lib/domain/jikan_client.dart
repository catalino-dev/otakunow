import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:otakunow/domain/search_result.dart';
import 'package:otakunow/domain/search_result_error.dart';

class JikanClient {
  final String baseUrl;
  final http.Client httpClient;

  JikanClient({
    http.Client httpClient,
    this.baseUrl = "https://api.jikan.moe/v3/search/anime?q=",
  }) : this.httpClient = httpClient ?? http.Client();

  Future<SearchResult> search(String term) async {
    final response = await httpClient.get(Uri.parse("$baseUrl$term"));
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw SearchResultError.fromJson(results);
    }
  }
}
