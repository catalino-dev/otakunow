import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:otakunow/domain/search/search_result.dart';
import 'package:otakunow/domain/search/search_result_error.dart';
import 'package:otakunow/domain/episodes/series_episodes.dart';

class JikanClient {
  final String baseUrl;
  final http.Client httpClient;

  JikanClient({
    http.Client httpClient,
    this.baseUrl = 'https://api.jikan.moe/v3/search/anime?q=',
  }) : this.httpClient = httpClient ?? http.Client();

  Future<SearchResult> search(String term) async {
    final response = await httpClient.get("$baseUrl$term");
    final results = jsonDecode(response.body);
    print(response.statusCode);
    print(results);


    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw ApiErrorMessage.fromJson(results);
    }
  }

  Future<SeriesEpisodes> fetchResource(int resourceId) async {
    final response = await httpClient.get("https://api.jikan.moe/v3/anime/$resourceId/episodes");
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return SeriesEpisodes.fromJson(results);
    } else {
      throw ApiErrorMessage.fromJson(results);
    }
  }
}
