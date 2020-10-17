import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otakunow/config/palette.dart';
import 'package:otakunow/domain/episodes/series_episode.dart';

class EpisodeScreen extends StatefulWidget {
  final SeriesEpisode episode;

  EpisodeScreen({this.episode});

  @override
  _EpisodeScreenState createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "background-${widget.episode.episodeNo}",
      child: Scaffold(
        backgroundColor: Palette.primaryBg,
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(left: 30.0),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                    ),
                    Image(
                      image: AssetImage('assets/images/otaku_logo.png'),
                      height: 60.0,
                      width: 150.0,
                      color: Colors.white,
                    ),
                    IconButton(
                      padding: EdgeInsets.only(right: 30.0),
                      onPressed: () => print('Thanks for the heart.'),
                      icon: Icon(Icons.favorite),
                      iconSize: 30.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Text(
                    widget.episode.title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.episode.titleInJapanese,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.0),
                  Divider(
                      color: Colors.white70
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'AIRING',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            new DateFormat.yMMMd().format(DateTime.parse(widget.episode.aired)),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'EPISODE',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            widget.episode.episodeNo.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'FILLER',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            widget.episode.filler ? 'Yes' : 'No',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
