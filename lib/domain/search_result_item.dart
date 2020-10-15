class SearchResultItem {
  // final String id;
  final String url;
  final String imageUrl;
  final String title;
  // final bool airing;
  // final String synopsis;
  // final String type;
  // final String episodes;
  // final String score;
  // final String startDate;
  // final String endDate;
  // final String rated;

  SearchResultItem(this.url, this.imageUrl, this.title);

  // SearchResultItem(this.id, this.url, this.imageUrl, this.title, this.airing, this.synopsis,
  //     this.type, this.episodes, this.score, this.startDate, this.endDate, this.rated);

  static SearchResultItem fromJson(dynamic json) {
    return SearchResultItem(
      json['url'],
      json['image_url'],
      json['title'],
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
