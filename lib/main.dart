import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakunow/config/theme.dart';
import 'package:otakunow/domain/episodes/series_episode_cache.dart';
import 'package:otakunow/domain/episodes/series_episodes_bloc.dart';
import 'package:otakunow/domain/jikan_client.dart';
import 'package:otakunow/domain/search/series_cache.dart';
import 'package:otakunow/domain/search/series_search_bloc.dart';
import 'package:otakunow/domain/series_repository.dart';
import 'package:otakunow/screens/screens.dart';
import 'package:otakunow/screens/series_screen.dart';

void main() {
  runApp(OtakuNowApp());
}

class OtakuNowApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otaku Now',
      debugShowCheckedModeBanner: false,
      theme: otakuTheme(),
      home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  final SeriesRepository _seriesRepository = SeriesRepository(
    SeriesCache(),
    SeriesEpisodeCache(),
    JikanClient(),
  );

  @override
  _SplashScreenState createState() => _SplashScreenState(
    seriesRepository: _seriesRepository
  );
}

class _SplashScreenState extends State<SplashScreen> {
  final SeriesRepository seriesRepository;

  _SplashScreenState({this.seriesRepository});

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
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
                    child: SeriesScreen(),
                  ),
                ],
                child: SearchScreen(),
              ),
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        'assets/otaku_splash.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'splash',
      ),
    );
  }
}
