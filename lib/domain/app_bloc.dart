import 'package:otakunow/domain/episodes/series_episodes_bloc.dart';
import 'package:otakunow/domain/search/series_search_bloc.dart';

class AppBloc {
  SeriesSearchBloc _searchBloc;
  SeriesEpisodesBloc _episodesBloc;

  AppBloc() {
    _searchBloc = SeriesSearchBloc();
    _episodesBloc = SeriesEpisodesBloc();
    // _searchBloc.counter$.listen(_evenCounter.increment.add);
  }

  SeriesSearchBloc get searchBloc => _searchBloc;
  SeriesEpisodesBloc get episodesBloc => _episodesBloc;
}
