import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/contractor_list/domain/contractor_repository.dart';
import 'package:test/test.dart';

class MockContractorRepository extends Mock implements ContractorRepository {}

void main() {
  group(SearchBloc, () {
    late SearchBloc searchBloc;
    late MockContractorRepository mockRepository;

    setUp(() {
      mockRepository = MockContractorRepository();
      searchBloc = SearchBloc(mockRepository);
    });

    test('initial state is ', () {
      expect(searchBloc.state, equals(const SearchState()));
    });

    blocTest<SearchBloc, SearchState>(
      'emits [query i] when SearchTextUpdated',
      build: () => SearchBloc(mockRepository),
      act: (bloc) => bloc.add(const SearchTextUpdated(query: 'i')),
      expect: () =>
          [const SearchState(query: 'i', status: SearchStateStatus.valid)],
    );
  });
}
