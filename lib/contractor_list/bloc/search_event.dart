part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchTextUpdated extends SearchEvent {
  const SearchTextUpdated({required this.query});

  final String query;

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'Search Commenced {query: $query}';
}

class SearchButtonPressed extends SearchEvent {
  const SearchButtonPressed();
}

class SearchFilterPressed extends SearchEvent {
  const SearchFilterPressed({required this.filter});

  final String filter;

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'Search filtered {filter: $filter}';
}

class SearchSortPressed extends SearchEvent {
  const SearchSortPressed({required this.sort});

  final bool sort;

  @override
  List<Object> get props => [sort];

  @override
  String toString() => 'Search filtered {sort: $sort}';
}
