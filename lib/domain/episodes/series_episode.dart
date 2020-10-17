class SeriesEpisode {
  // final String id;
  final String episodeNo;
  final String title;
  final String titleInJapanese;
  final String aired;
  final bool filler;

  SeriesEpisode(this.episodeNo, this.title, this.titleInJapanese, this.aired, this.filler);

  static SeriesEpisode fromJson(dynamic json) {
    return SeriesEpisode(
      json['episode_id'],
      json['title'],
      json['title_japanese'],
      json['aired'],
      json['filler'],
    );
  }
}
