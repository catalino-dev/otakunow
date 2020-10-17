import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:otakunow/domain/search/search_result.dart';
import 'package:otakunow/domain/search/search_result_error.dart';
import 'package:otakunow/domain/episodes/series_episodes.dart';

class JikanClient {
  final http.Client httpClient;

  static const String JIKAN_API_BASE_URL = 'https://api.jikan.moe/v3';
  static const String JIKAN_RESOURCE_TYPE = 'anime';

  JikanClient({
    http.Client httpClient,
  }) : this.httpClient = httpClient ?? http.Client();

  Future<SearchResult> search(String term) async {
    final response = await httpClient.get("$JIKAN_API_BASE_URL/search/$JIKAN_RESOURCE_TYPE?q=$term");
    final results = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return SearchResult.fromJson(results);
    } else {
      throw ApiErrorMessage.fromJson(results);
    }
  }

  Future<SeriesEpisodes> fetchResource(int resourceId) async {
    final response = await httpClient.get("$JIKAN_API_BASE_URL/$JIKAN_RESOURCE_TYPE/$resourceId/episodes");
    final results = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return SeriesEpisodes.fromJson(results);
    } else {
      throw ApiErrorMessage.fromJson(results);
    }
  }
}
