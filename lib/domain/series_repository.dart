import 'dart:async';

import 'package:otakunow/domain/episodes/series_episode_cache.dart';
import 'package:otakunow/domain/episodes/series_episodes.dart';
import 'package:otakunow/domain/jikan_client.dart';
import 'package:otakunow/domain/search/search_result.dart';
import 'package:otakunow/domain/search/series_cache.dart';

class SeriesRepository {
  final SeriesCache cache;
  final SeriesEpisodeCache episodeCache;
  final JikanClient client;

  SeriesRepository(this.cache, this.episodeCache, this.client);

  Future<SearchResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      final result = await client.search(term);
      cache.set(term, result);
      return result;
    }
  }

  Future<SeriesEpisodes> fetchResource(int id) async {
    if (episodeCache.contains(id)) {
      return episodeCache.get(id);
    } else {
      final result = await client.fetchResource(id);
      episodeCache.set(id, result);
      return result;
    }
  }
}
