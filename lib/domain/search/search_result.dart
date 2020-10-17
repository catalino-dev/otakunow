import 'package:otakunow/domain/search/search_result_item.dart';

class SearchResult {
  final List<SearchResultItem> results;

  const SearchResult({this.results});

  static SearchResult fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>)
        .map((dynamic item) => SearchResultItem.fromJson(item as Map<String, dynamic>))
        .toList();
    return SearchResult(results: results);
  }
}
