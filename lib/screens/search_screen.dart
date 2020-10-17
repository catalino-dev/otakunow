import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakunow/domain/episodes/series_episodes_bloc.dart';
import 'package:otakunow/domain/search/search_result_item.dart';
import 'package:otakunow/domain/search/series_search_bloc.dart';
import 'package:otakunow/domain/search/series_search_event.dart';
import 'package:otakunow/domain/search/series_search_state.dart';
import 'package:otakunow/screens/series_screen.dart';
import 'package:otakunow/widgets/no_results.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_SearchBar(), _SearchBody()],
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textController = TextEditingController();
  SeriesSearchBloc _seriesSearchBloc;

  @override
  void initState() {
    super.initState();
    _seriesSearchBloc = BlocProvider.of<SeriesSearchBloc>(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autocorrect: false,
      onChanged: (text) {
        _seriesSearchBloc.add(
          TextChanged(text: text),
        );
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: GestureDetector(
          onTap: _onClearTapped,
          child: const Icon(Icons.clear),
        ),
        border: InputBorder.none,
        hintText: 'Enter a search term',
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    _seriesSearchBloc.add(const TextChanged(text: ''));
  }
}

class _SearchBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenHeight= MediaQuery.of(context).size.height;

    return BlocBuilder<SeriesSearchBloc, SeriesSearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return Column(
            children: [
              Container(
                height: screenHeight / 3,
                child: const FlareActor(
                  'assets/earth.flr',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.scaleDown,
                  animation: 'loading',
                ),
              ),
              Text(
                "Searching the world...",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          );
        }
        if (state is SearchStateError) {
          return NoResults();
        }
        if (state is SearchStateSuccess) {
          return state.results.isEmpty
              ? NoResults()
              : Expanded(child: _SearchResults(results: state.results));
        }
        return Column(
          children: [
            Container(
              height: screenHeight / 3,
              child: const FlareActor(
                'assets/earth.flr',
                alignment: Alignment.topCenter,
                fit: BoxFit.scaleDown,
                animation: 'idle',
              ),
            ),
            Text(
              "Try searching for an anime title...",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<SearchResultItem> results;

  const _SearchResults({Key key, this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: results.length,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: results[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  final SearchResultItem item;

  const _SearchResultItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
            BlocProvider.value(
              value: BlocProvider.of<SeriesEpisodesBloc>(context),
              child: SeriesScreen(item: item),
            ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 4.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Hero(
          tag: item.imageUrl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover
            ),
          ),
        ),
      ),
    );
  }
}
