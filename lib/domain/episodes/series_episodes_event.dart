import 'package:equatable/equatable.dart';

abstract class SeriesEpisodesEvent extends Equatable {
  const SeriesEpisodesEvent();
}

class ResourceUpdated extends SeriesEpisodesEvent {
  final int resourceId;

  const ResourceUpdated({this.resourceId});

  @override
  List<Object> get props => [resourceId];

  @override
  String toString() => 'PageChanged { resource: $resourceId }';
}
