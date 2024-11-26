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

  SearchBloc(this.repository): super(SearchState.initial()) {
     //call state here directly dont call getcontractors and if it isnt empty call it
    on<SearchTextUpdated>(
      (event, emit) async{
        if(event.query.isEmpty){
          emit(state.copyWith(isButtonOn: false, errormsg: 'User input failed to enter anyhting', query: event.query,
          status: SearchStateStatus.invalid));
        } else {
          emit(state.copyWith(isButtonOn:true, query: event.query, status: SearchStateStatus.valid));
        }
      });

    on<SearchButtonPressed>( 
      (event, emit) async {
        try{
          emit(state.copyWith(isButtonOn: false, status: SearchStateStatus.loading)); //emit the loading state
          //print(state.query);
          await Future<void>.delayed(const Duration(seconds:1));
          final contractors = await repository.getContractors(state.query);//state.query
          //print(state.query);
          emit(state.copyWith(contractors: contractors, status: SearchStateStatus.success));
        } catch(error) {
          emit(state.copyWith(errormsg: '$error', status: SearchStateStatus.failure));
        }
      });
  }
}
//have the bloc instead of a controller manage the texts in the bloc
//make sure that its a valid query 


/* hide the search button or disable it when the user doesnt enter anything or if its invalid*/
