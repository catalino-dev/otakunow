import 'package:otakunow/domain/episodes/series_episode.dart';

class SeriesEpisodes {
  final List<SeriesEpisode> episodes;

  const SeriesEpisodes({this.episodes});

  static SeriesEpisodes fromJson(Map<String, dynamic> json) {
    final episodes = (json['episodes'] as List<dynamic>)
        .map((dynamic item) => SeriesEpisode.fromJson(item as Map<String, dynamic>))
        .toList();
    return SeriesEpisodes(episodes: episodes);
  }
}
