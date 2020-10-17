import 'package:equatable/equatable.dart';

abstract class SeriesSearchEvent extends Equatable {
  const SeriesSearchEvent();
}

class TextChanged extends SeriesSearchEvent {
  final String text;

  const TextChanged({this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
