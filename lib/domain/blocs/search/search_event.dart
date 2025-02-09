part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

final class OnSearchChange extends SearchEvent {
  final String text;

  const OnSearchChange({required this.text});

  @override
  List<Object?> get props => [text];
}
