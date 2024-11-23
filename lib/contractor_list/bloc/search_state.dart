//apps state in particular moments
part of 'search_bloc.dart';

abstract class SearchState extends Equatable{ //Equatable tells Dart, "Don't just compare where they are in memory; check their actual content."
  const SearchState();
//bloc rebuilds the UI everytime the state changes
//using equatable with states will allow bloc to not rebuild the UI if two states are identical
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {} //going to show nothing 

class SearchSuccess extends SearchState {
  final List<Contractor> contractors;
  const SearchSuccess(this.contractors);
    //u have to do the thing below because then bloc wont be able to compare the states
    @override
    List<Object> get props => [contractors];
    @override
    String toString() => 'SearchSuccess { items: $contractors.length} }';
} //gonna show the list of contractors reuested ;;; this will have access to the list of contractors

class SearchFailure extends SearchState {} //show an error page

class SearchInvalid extends SearchState {
    final String errormsg;
    final bool isButtonOn;
    const SearchInvalid(this.errormsg,{this.isButtonOn = false});
    //u have to do the thing below because then bloc wont be able to compare the states
    @override
    List<Object> get props => [errormsg, isButtonOn];
} 

class SearchInProgress extends SearchState{
    final bool isButtonOn;
    const SearchInProgress({this.isButtonOn = false});
    @override
    List<Object> get props => [isButtonOn];  
} //show a circle loading symbol

class SearchValid extends SearchState {
  final bool isButtonOn;
  final String query; //use copyWith to persist it thru states

  const SearchValid(this.query, {this.isButtonOn = true});

    @override
    List<Object> get props => [query, isButtonOn];
  
} 
