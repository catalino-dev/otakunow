class SearchResultItem {
  final int id;
  final String url;
  final String imageUrl;
  final String title;
  // final bool airing;
  // final String type;
  final int episodes;
  final String synopsis;
  // final String score;
  // final String startDate;
  // final String endDate;
  // final String rated;

  SearchResultItem(this.id, this.url, this.imageUrl, this.title, this.episodes, this.synopsis);

  // SearchResultItem(this.id, this.url, this.imageUrl, this.title, this.airing, this.synopsis,
  //     this.type, this.episodes, this.score, this.startDate, this.endDate, this.rated);

  static SearchResultItem fromJson(dynamic json) {
    return SearchResultItem(
      json['mal_id'] as int,
      json['url'],
      json['image_url'],
      json['title'],
      json['episodes'] as int,
      json['synopsis'],
    );
    // return SearchResultItem(
    //   json['mal_id'],
    //   json['url'],
    //   json['image_url'],
    //   json['title'],
    //   json['airing'],
    //   json['synopsis'],
    //   json['type'],
    //   json['episodes'],
    //   json['score'],
    //   json['start_date'],
    //   json['end_date'],
    //   json['rated'],
    // );
  }
}
