import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakunow/domain/search_result_item.dart';
import 'package:otakunow/domain/series_search_bloc.dart';
import 'package:otakunow/domain/series_search_event.dart';
import 'package:otakunow/domain/series_search_state.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return BlocBuilder<SeriesSearchBloc, SeriesSearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess) {
          return state.results.isEmpty
              ? const Text('No Results')
              : Expanded(child: _SearchResults(results: state.results));
        }
        return const Text('Please enter a term to begin');
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<SearchResultItem> results;

  const _SearchResults({Key key, this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
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
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(item.imageUrl),
      ),
      title: Text(item.title),
      onTap: () async {
        if (await canLaunch(item.url)) {
          await launch(item.url);
        }
      },
    );
  }
}
