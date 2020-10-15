import 'dart:async';

import 'package:otakunow/domain/jikan_client.dart';
import 'package:otakunow/domain/search_result.dart';
import 'package:otakunow/domain/series_cache.dart';

class SeriesRepository {
  final SeriesCache cache;
  final JikanClient client;

  SeriesRepository(this.cache, this.client);

  Future<SearchResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      final result = await client.search(term);
      cache.set(term, result);
      return result;
    }
  }
}
