import 'dart:async';

import 'package:meta/meta.dart';
import 'package:otakunow/domain/search/search_result_error.dart';
import 'package:otakunow/domain/series_repository.dart';
import 'package:otakunow/domain/search/series_search_event.dart';
import 'package:otakunow/domain/search/series_search_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class SeriesSearchBloc extends Bloc<SeriesSearchEvent, SeriesSearchState> {
  final SeriesRepository githubRepository;

  SeriesSearchBloc({@required this.githubRepository})
      : super(SearchStateEmpty());

  @override
  Stream<Transition<SeriesSearchEvent, SeriesSearchState>> transformEvents(
    Stream<SeriesSearchEvent> events,
    Stream<Transition<SeriesSearchEvent, SeriesSearchState>> Function(
      SeriesSearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 600))
        .switchMap(transitionFn);
  }

  @override
  Stream<SeriesSearchState> mapEventToState(SeriesSearchEvent event) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          await Future<void>.delayed(Duration(seconds: 3));
          final query = await githubRepository.search(searchTerm);
          yield SearchStateSuccess(query.results);
        } catch (error) {
          yield error is ApiErrorMessage
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    }
  }
}
