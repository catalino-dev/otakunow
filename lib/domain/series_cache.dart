import 'package:otakunow/domain/search_result.dart';

class SeriesCache {
  final _cache = <String, SearchResult>{};

  SearchResult get(String term) => _cache[term];

  void set(String term, SearchResult result) => _cache[term] = result;

  bool contains(String term) => _cache.containsKey(term);

  void remove(String term) => _cache.remove(term);
}