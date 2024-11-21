//receives events and produces states
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/contractor_list/domain/contractor_repository.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
part 'search_state.dart';
part 'search_event.dart';
//have a try catch here and emit error state 
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ContractorRepository repository;

  SearchBloc(this.repository): super(SearchInitial()) {
     //call state here directly dont call getcontractors and if it isnt empty call it
     //////BRIDGET AND INIKASS WQUESITON 11:03 PM -> How are we able to determine whats a valid input or not, like what if the user is using the search to look up using ids, using names/case sensitiveness
    on<SearchTextUpdated>(
      (event, emit) async{
        if(event.query.isEmpty){
          emit(const SearchInvalid("User input failed to enter anyhting"));
        } else {
          emit(SearchValid(event.query));
        }
      });

    on<SearchButtonPressed>( 
      (event, emit) async {
        emit(SearchInProgress()); //emit the loading state
        await Future<void>.delayed(const Duration(seconds:1));
        final contractors = await repository.getContractors(event.query);
        emit(SearchSuccess(contractors));
      });
  }
}
//have the bloc instead of a controller manage the texts in the bloc
//make sure that its a valid query 


/* hide the search button or disable it when the user doesnt enter anything or if its invalid*/
