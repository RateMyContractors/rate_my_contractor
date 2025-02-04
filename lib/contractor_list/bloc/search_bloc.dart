//receives events and produces states
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/contractor_list/domain/contractor_repository.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
part 'search_state.dart';
part 'search_event.dart';

//have a try catch here and emit error state
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository)
      : super(
          const SearchState(),
        ) {
    on<SearchTextUpdated>((event, emit) async {
      if (event.query.isEmpty) {
        emit(
          state.copyWith(
            errormsg: 'User input failed to enter anyhting',
            query: event.query,
            status: SearchStateStatus.invalid,
          ),
        );
      } else {
        emit(
          state.copyWith(
            query: event.query,
            status: SearchStateStatus.valid,
          ),
        );
      }
    });

    on<SearchButtonPressed>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: SearchStateStatus.loading,
          ),
        ); //emit the loading state
        final contractors =
            await repository.getContractors(state.query); //state.query
        emit(
          state.copyWith(
            contractors: contractors,
            status: SearchStateStatus.success,
          ),
        );
      } on Exception catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: SearchStateStatus.failure,
          ),
        );
      }
    });
  }
  final ContractorRepository repository;
}
