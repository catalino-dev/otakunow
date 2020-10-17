import 'package:equatable/equatable.dart';
import 'package:otakunow/domain/search/search_result_item.dart';

abstract class SeriesSearchState extends Equatable {
  const SeriesSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SeriesSearchState {}

class SearchStateLoading extends SeriesSearchState {}

class SearchStateSuccess extends SeriesSearchState {
  final List<SearchResultItem> results;

  const SearchStateSuccess(this.results);

  @override
  List<Object> get props => [results];

  @override
  String toString() => 'SearchStateSuccess { items: ${results.length} }';
}

class SearchStateError extends SeriesSearchState {
  final String error;

  const SearchStateError(this.error);

  @override
  List<Object> get props => [error];
}
