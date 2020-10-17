import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  final int id;
  final String url;
  final String imageUrl;
  final String title;
  final bool airing;
  final String synopsis;
  final String type;
  final String episodes;
  final String score;
  final String startDate;
  final String endDate;
  final String rated;

  SeriesModel(this.id, this.url, this.imageUrl, this.title, this.airing, this.synopsis,
      this.type, this.episodes, this.score, this.startDate, this.endDate, this.rated);

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      json['mal_id'],
      json['url'],
      json['image_url'],
      json['title'],
      json['airing'],
      json['synopsis'],
      json['type'],
      json['episodes'],
      json['score'],
      json['start_date'],
      json['end_date'],
      json['rated'],
    );
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
