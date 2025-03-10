part of 'search_bloc.dart';

enum SearchStateStatus { initial, loading, failure, success, valid, invalid }

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.errormsg = '',
    this.contractors = const [],
    this.status = SearchStateStatus.initial,
    this.filter = 0,
    this.sort = true,
  });
  final SearchStateStatus status;
  final String query;
  final String errormsg;
  final List<Contractor> contractors;
  final int filter;
  final bool sort;

  SearchState copyWith({
    String? query,
    String? errormsg,
    List<Contractor>? contractors,
    SearchStateStatus? status,
    int? filter,
    bool? sort,
  }) {
    return SearchState(
      query: query ?? this.query,
      errormsg: errormsg ?? this.errormsg,
      contractors: contractors ?? this.contractors,
      status: status ?? this.status,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props =>
      [status, query, errormsg, contractors, filter, sort];

  @override
  String toString() =>
      'SearchState(isButtonOn: query: $query, errormsg: $errormsg, '
      'contractors: $contractors, status: $status)';
}
