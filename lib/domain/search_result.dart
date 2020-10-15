import 'package:otakunow/domain/search_result_item.dart';

class SearchResult {
  final List<SearchResultItem> results;

  const SearchResult({this.results});

  static SearchResult fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>)
        .map((dynamic item) {
          SearchResultItem result = SearchResultItem.fromJson(item as Map<String, dynamic>);
          print('===============result===============');
          print(result);
          return result;
        }
        ).toList();
    return SearchResult(results: results);
  }
}
