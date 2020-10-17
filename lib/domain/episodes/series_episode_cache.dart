import 'package:otakunow/domain/episodes/series_episodes.dart';

class SeriesEpisodeCache {
  final _cache = <int, SeriesEpisodes>{};

  SeriesEpisodes get(int resourceId) => _cache[resourceId];

  void set(int resourceId, SeriesEpisodes result) => _cache[resourceId] = result;

  bool contains(int resourceId) => _cache.containsKey(resourceId);

  void remove(int resourceId) => _cache.remove(resourceId);
}
