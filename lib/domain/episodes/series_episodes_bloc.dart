import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:otakunow/domain/episodes/series_episodes_event.dart';
import 'package:otakunow/domain/episodes/series_episodes_state.dart';
import 'package:otakunow/domain/search/search_result_error.dart';
import 'package:otakunow/domain/series_repository.dart';
import 'package:rxdart/rxdart.dart';

class SeriesEpisodesBloc extends Bloc<SeriesEpisodesEvent, SeriesEpisodesState> {
  final SeriesRepository seriesRepository;

  SeriesEpisodesBloc({@required this.seriesRepository})
      : super(EpisodeStateEmpty());

  @override
  Stream<Transition<SeriesEpisodesEvent, SeriesEpisodesState>> transformEvents(
    Stream<SeriesEpisodesEvent> events,
    Stream<Transition<SeriesEpisodesEvent, SeriesEpisodesState>> Function(
      SeriesEpisodesEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 600))
        .switchMap(transitionFn);
  }

  @override
  Stream<SeriesEpisodesState> mapEventToState(SeriesEpisodesEvent event) async* {
    if (event is ResourceChanged) {
      final int resourceId = event.resourceId;
      if (resourceId == null) {
        yield EpisodeStateEmpty();
      } else {
        yield EpisodeStateLoading();
        try {
          await Future<void>.delayed(Duration(seconds: 3));
          final query = await seriesRepository.fetchResource(resourceId);
          yield EpisodeStateSuccess(query.episodes);
        } catch (error) {
          yield error is ApiErrorMessage
              ? EpisodeStateError(error.message)
              : EpisodeStateError('something went wrong');
        }
      }
    }
  }
}
