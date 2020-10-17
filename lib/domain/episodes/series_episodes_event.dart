import 'package:equatable/equatable.dart';

abstract class SeriesEpisodesEvent extends Equatable {
  const SeriesEpisodesEvent();
}

class ResourceChanged extends SeriesEpisodesEvent {
  final int resourceId;

  const ResourceChanged({this.resourceId});

  @override
  List<Object> get props => [resourceId];

  @override
  String toString() => 'PageChanged { resource: $resourceId }';
}
