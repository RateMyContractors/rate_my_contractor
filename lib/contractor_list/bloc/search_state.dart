part of 'search_bloc.dart';


enum SearchStateStatus {initial, loading, failure, success, invalid, valid}
class SearchState extends Equatable{
  final SearchStateStatus status;
  final bool isButtonOn;
  final String query;
  final String errormsg;
  final List<Contractor> contractors;

  SearchState({
    required this.isButtonOn,
    required this.query,
    required this.errormsg,
    required this.contractors,
    required this.status
  });

  // Default initial state
  factory SearchState.initial() { //set initial vals in the constructor
    return SearchState(
      status: SearchStateStatus.initial,
      isButtonOn: false,
      query: '',
      errormsg: '',
      contractors: []
    );
  }

  SearchState copyWith({
    bool? isButtonOn,
    String? query, 
    String? errormsg,
    List<Contractor>? contractors,
    required SearchStateStatus status
  }) {
    return SearchState(
      isButtonOn: isButtonOn ?? this.isButtonOn,
      query: query ?? this.query,
      errormsg: errormsg ?? this.errormsg, 
      contractors: contractors ?? this.contractors,
      status: status,
    );
  }

  @override
  List<Object?> get props => [status, isButtonOn, query, errormsg, contractors];

  @override
  String toString() =>
      'SearchState(isButtonOn: $isButtonOn, query: $query, errormsg: $errormsg, contractors: $contractors, status: $status)';
}
