//triggered by the user
part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable{
  const SearchEvent();

  @override
  List<Object> get props => [];
}

/*new event everytime a user updates the text*/
class SearchTextUpdated extends SearchEvent {
  const SearchTextUpdated({required this.query});

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'Search Commenced {text: $query}';
}

class SearchButtonPressed extends SearchEvent {
  const SearchButtonPressed({required this.query});

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'Search Commenced {text: $query}';
}

