class SearchResultItem {
  final int id;
  final String url;
  final String imageUrl;
  final String title;
  final bool airing;
  final int episodes;
  final String synopsis;

  SearchResultItem(this.id, this.url, this.imageUrl, this.title, this.airing, this.episodes, this.synopsis);

  static SearchResultItem fromJson(dynamic json) {
    return SearchResultItem(
      json['mal_id'] as int,
      json['url'],
      json['image_url'],
      json['title'],
      json['airing'] as bool,
      json['episodes'] as int,
      json['synopsis'],
    );
  }
}
