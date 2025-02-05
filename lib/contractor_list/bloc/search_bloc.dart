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

    on<SearchSortPressed>((event, emit) async {
      try {
        emit(
          state.copyWith(sort: event.sort, status: SearchStateStatus.valid),
        );
        emit(
          state.copyWith(
            status: SearchStateStatus.loading,
          ),
        );
        final contractors = await repository.getContractors(
          state.query,
          sortcontractors: event.sort,
        ); //state.query
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

    on<SearchButtonPressed>((event, emit) async {
      try {
        emit(
          state.copyWith(
            status: SearchStateStatus.loading,
          ),
        );
        final contractors = await repository.getContractors(
          state.query,
          sortcontractors: state.sort,
        ); //state.query
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

    on<SearchFilterPressed>(
      (event, emit) async {
        List<Contractor> filteredContractors;
        final contractors = await repository.getContractors(
          state.query,
          sortcontractors: state.sort,
        ); //state.query
        if (event.filter == 100) {
          filteredContractors = contractors;
        } else {
          filteredContractors = contractors.where((contractor) {
            return contractor.rating >= event.filter &&
                contractor.rating < event.filter + 1.0;
          }).toList();
        }
        emit(
          state.copyWith(
            filter: event.filter,
            contractors: filteredContractors,
            status: SearchStateStatus.success,
          ),
        );
      },
    );
  }
  final ContractorRepository repository;
}
