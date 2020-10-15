import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakunow/domain/jikan_client.dart';
import 'package:otakunow/domain/series_cache.dart';
import 'package:otakunow/domain/series_repository.dart';
import 'package:otakunow/domain/series_search_bloc.dart';
import 'package:otakunow/screens/screens.dart';

void main() {
  final SeriesRepository _githubRepository = SeriesRepository(
    SeriesCache(),
    JikanClient(),
  );

  runApp(OtakuNowApp(githubRepository: _githubRepository));
}

class OtakuNowApp extends StatelessWidget {
  final SeriesRepository githubRepository;

  const OtakuNowApp({
    Key key,
    @required this.githubRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otaku Now',
      home: Scaffold(
        appBar: AppBar(title: const Text('Otaku Now')),
        body: BlocProvider(
          create: (context) =>
              SeriesSearchBloc(githubRepository: githubRepository),
          child: SearchScreen(),
        ),
      ),
    );
  }
}
