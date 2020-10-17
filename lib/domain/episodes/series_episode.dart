import 'package:otakunow/screens/content_item.dart';

class SeriesEpisode extends ContentItem {
  final int episodeNo;
  final String title;
  final String titleInJapanese;
  final String aired;
  final bool filler;

  SeriesEpisode(this.episodeNo, this.title, this.titleInJapanese, this.aired, this.filler) : super(episodeNo, title);

  static SeriesEpisode fromJson(dynamic json) {
    return SeriesEpisode(
      json['episode_id'] as int,
      json['title'],
      json['title_japanese'],
      json['aired'],
      json['filler'] as bool,
    );
  }
}
