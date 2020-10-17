import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:otakunow/domain/episodes/series_episodes.dart';
import 'package:otakunow/domain/jikan_client.dart';
import 'package:otakunow/domain/search/search_result.dart';

// TODO: Tests should be written from the requirements stated above, including rate limited scenario.
class MockJikanClient extends Mock implements http.Client {}

main() {
  group('search', () {
    final baseUrl = 'https://api.jikan.moe/v3/search/anime?q=';
    final httpClient = MockJikanClient();
    final jikanClient = JikanClient(baseUrl: baseUrl, httpClient: httpClient);

    test('returns a JikanClient if the http call completes successfully', () async {
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

      when(httpClient.get(Uri.parse("$baseUrl$term")))
          .thenAnswer((_) async => http.Response(searchResult, 200));

      expect(await jikanClient.search(term), isA<SearchResult>());
    });

    test('throws an exception if the http call completes with an error', () {
      final term = 'fairy';

      when(httpClient.get(Uri.parse("$baseUrl$term")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(jikanClient.search(term), throwsException);
    });
  });

  group('fetchResource', () {
    final baseUrl = 'https://api.jikan.moe/v3/anime/';
    final httpClient = MockJikanClient();
    final jikanClient = JikanClient(baseUrl: baseUrl, httpClient: httpClient);

    test('returns a JikanClient if the http call completes successfully', () async {
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

      when(httpClient.get(Uri.parse("$baseUrl$resourceId/episodes")))
          .thenAnswer((_) async => http.Response(episodes, 200));

      expect(await jikanClient.fetchResource(resourceId), isA<SeriesEpisodes>());
    });

    test('throws an exception if the http call completes with an error', () {
      final resourceId = 4725;

      when(httpClient.get(Uri.parse("$baseUrl$resourceId/episodes")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(jikanClient.fetchResource(resourceId), throwsException);
    });
  });
}
