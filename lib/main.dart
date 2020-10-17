import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakunow/domain/episodes/series_episodes_bloc.dart';
import 'package:otakunow/domain/jikan_client.dart';
import 'package:otakunow/domain/search/series_cache.dart';
import 'package:otakunow/domain/episodes/series_episode_cache.dart';
import 'package:otakunow/domain/series_repository.dart';
import 'package:otakunow/domain/search/series_search_bloc.dart';
import 'package:otakunow/screens/screens.dart';

void main() {
  final SeriesRepository _seriesRepository = SeriesRepository(
    SeriesCache(),
    SeriesEpisodeCache(),
    JikanClient(),
  );

  runApp(OtakuNowApp(seriesRepository: _seriesRepository));
}

class OtakuNowApp extends StatelessWidget {
  final SeriesRepository seriesRepository;

  const OtakuNowApp({
    Key key,
    @required this.seriesRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otaku Now',
      home: Scaffold(
        appBar: AppBar(title: const Text('Otaku Now')),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<SeriesSearchBloc>(
              create: (BuildContext context) =>
                  SeriesSearchBloc(seriesRepository: seriesRepository),
            ),
            BlocProvider<SeriesEpisodesBloc>(
              create: (BuildContext context) =>
                  SeriesEpisodesBloc(seriesRepository: seriesRepository),
            ),
          ],
          child: SearchScreen(),
        ),
      ),
    );
  }
}
