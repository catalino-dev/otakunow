import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:otakunow/domain/episodes/series_episodes.dart';
import 'package:otakunow/domain/jikan_client.dart';
import 'package:otakunow/domain/search/search_result.dart';
import 'package:otakunow/domain/search/search_result_error.dart';

class MockJikanClient extends Mock implements http.Client {}

main() {
  group('search', () {
    final baseUrl = 'https://api.jikan.moe/v3/search/anime?q=';
    final httpClient = MockJikanClient();
    final jikanClient = JikanClient(httpClient: httpClient);

    test('should be able to search for a series title with the given search term', () async {
      final term = 'zero';

      final searchResult = '{"results": [{'
        '"url": "https://myanimelist.net/anime/4725/Ga-Rei__Zero", '
        '"image_url": "https://cdn.myanimelist.net/images/anime/9/11355.jpg?s=d7a6696fa0918b7f91c03a17d38db5ec", '
        '"title": "Ga-Rei: Zero", '
        '"airing": false, '
        '"synopsis": "In Japan, there exists a government agency...", '
        '"type": "TV", '
        '"episodes": 12, '
        '"score": 7.64, '
        '"start_date": "2008-10-06T00:00:00+00:00", '
        '"end_date": "2008-12-22T00:00:00+00:00", '
        '"members": 200134, '
        '"rated": "R"'
      '}]}';

      when(httpClient.get("$baseUrl$term"))
          .thenAnswer((_) async => http.Response(searchResult, 200));

      expect(await jikanClient.search(term), isA<SearchResult>());
    });

    test('should throw an exception if the http call completes with 404 Not Found error', () {
      final term = 'fairy';

      final errorResult = '{'
          '"status": 404, '
          '"type": "BadResponseException", '
          '"message": "Resource does not exist", '
          '"error": "Something Happened"'
          '}';

      when(httpClient.get("$baseUrl$term"))
          .thenAnswer((_) async => http.Response(errorResult, 404));

      expect(jikanClient.search(term), throwsA(isA<ApiErrorMessage>()));
    });

    test('should throw an exception if the http call completes with 429 Too Many Requests error', () {
      final term = 'tail';

      final errorResult = '{'
          '"status": 429, '
          '"type": "TooManyRequestException", '
          '"message": "Too Many Request", '
          '"error": "Something Happened"'
          '}';

      when(httpClient.get("$baseUrl$term"))
          .thenAnswer((_) async => http.Response(errorResult, 429));

      expect(jikanClient.search(term), throwsA(isA<ApiErrorMessage>()));
    });
  });

  group('fetchResource', () {
    final baseUrl = 'https://api.jikan.moe/v3/anime';
    final httpClient = MockJikanClient();
    final jikanClient = JikanClient(httpClient: httpClient);

    test('should be able to fetch resource details with the given series id', () async {
      final resourceId = 4725;

      final episodes = '{"episodes": '
        '[{"episode_id": 1, '
        '"title": "Above Aoi", '
        '"title_japanese": "\\u767b\\u9332", '
        '"title_romanji": "Aoi no Ue", '
        '"aired": "2008-10-06T00:00:00+00:00", '
        '"filler": false, '
        '"recap": false, '
        '"video_url": "https://myanimelist.net/anime/4725/Ga-Rei__Zero/episode/1", '
        '"forum_url": "https://myanimelist.net/forum/?topicid=46541"'
        '}, {"episode_id": 2, '
        '"title": "Expression of Hatred", '
        '"title_japanese": "\\u30d7\\u30e9\\u30f3", '
        '"title_romanji": "Nikushimi no Hatsuro", '
        '"aired": "2008-10-13T00:00:00+00:00", '
        '"filler": false, '
        '"recap": false, '
        '"video_url": "https://myanimelist.net/anime/4725/Ga-Rei__Zero/episode/2", '
        '"forum_url": "https://myanimelist.net/forum/?topicid=47679"'
      '}]}';

      when(httpClient.get("$baseUrl/$resourceId/episodes"))
          .thenAnswer((_) async => http.Response(episodes, 200));

      expect(await jikanClient.fetchResource(resourceId), isA<SeriesEpisodes>());
    });

    test('should throw an exception if the http call completes with 404 Not Found error', () {
      final resourceId = 9999;

      final errorResult = '{'
          '"status": 404, '
          '"type": "BadResponseException", '
          '"message": "Resource does not exist", '
          '"error": "Something Happened"'
          '}';

      when(httpClient.get("$baseUrl/$resourceId/episodes"))
          .thenAnswer((_) async => http.Response(errorResult, 404));

      expect(jikanClient.fetchResource(resourceId), throwsA(isA<ApiErrorMessage>()));
    });

    test('should throw an exception if the http call completes with 429 Too Many Requests error', () {
      final resourceId = 9999;

      final errorResult = '{'
          '"status": 429, '
          '"type": "TooManyRequestException", '
          '"message": "Too Many Request", '
          '"error": "Something Happened"'
          '}';

      when(httpClient.get("$baseUrl/$resourceId/episodes"))
          .thenAnswer((_) async => http.Response(errorResult, 429));

      expect(jikanClient.fetchResource(resourceId), throwsA(isA<ApiErrorMessage>()));
    });
  });
}
