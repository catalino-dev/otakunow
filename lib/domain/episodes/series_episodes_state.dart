import 'package:equatable/equatable.dart';
import 'package:otakunow/domain/episodes/series_episode.dart';

abstract class SeriesEpisodesState extends Equatable {
  const SeriesEpisodesState();

  @override
  List<Object> get props => [];
}

class EpisodeStateEmpty extends SeriesEpisodesState {}

class EpisodeStateLoading extends SeriesEpisodesState {}

class EpisodeStateSuccess extends SeriesEpisodesState {
  final List<SeriesEpisode> episodes;

  const EpisodeStateSuccess(this.episodes);

  @override
  List<Object> get props => [episodes];

  @override
  String toString() => 'EpisodeStateSuccess { items: ${episodes.length} }';
}

class EpisodeStateError extends SeriesEpisodesState {
  final String error;

  const EpisodeStateError(this.error);

  @override
  List<Object> get props => [error];
}
