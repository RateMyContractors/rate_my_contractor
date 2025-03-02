import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/contractor_list/domain/contractor_repository.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:test/test.dart';

class MockSearchBlocRepository extends Mock implements ContractorRepository {}

void main() {
  group(SearchBloc, () {
    late MockSearchBlocRepository mockRepository;

    setUp(() {
      mockRepository = MockSearchBlocRepository();
    });

    test('Search State works successfully', () {
      const searchstate = SearchState(query: 'i');

      expect(
          searchstate.toString(),
          'SearchState(isButtonOn: query: i, errormsg: '
          ', '
          'contractors: [], status: SearchStateStatus.initial)');
    });

    test('Search Event for SearchText updated', () {
      const searchtext = SearchTextUpdated(query: 'i');

      expect(searchtext.toString(), 'Search Commenced {query: i}');
    });

    test('Search Event for SearchFilterPressed', () {
      const searchtext = SearchFilterPressed(filter: 2);

      expect(searchtext.toString(), 'Search filtered {filter: 2}');
    });

    test('Search Sort Pressed for Search event', () {
      const searchtext = SearchSortPressed(sort: true);

      expect(searchtext.toString(), 'Search filtered {sort: true}');
    });

    test('SearchButton pressed', () {
      const searchtext = SearchButtonPressed();

      expect(searchtext.toString(), 'Search Button Pressed');
    });

    blocTest<SearchBloc, SearchState>(
      'search button pressed',
      build: () {
        when(
          () => mockRepository.getContractors(
            any(),
            sortcontractors: any(named: 'sortcontractors'),
          ),
        ).thenAnswer(
          (_) async => <Contractor>[
            const Contractor(
              id: '1',
              companyName: 'test',
              address: 'test123',
              tags: ['hi'],
              phone: '123',
              licenses: [],
              totalRating: [],
            ),
          ],
        );
        return SearchBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const SearchButtonPressed()),
      expect: () => [
        const SearchState(
          status: SearchStateStatus.loading,
        ),
        const SearchState(
          contractors: [
            Contractor(
              id: '1',
              companyName: 'test',
              address: 'test123',
              tags: ['hi'],
              phone: '123',
              licenses: [],
              totalRating: [],
            ),
          ],
          status: SearchStateStatus.success,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'search sort pressed',
      build: () {
        when(
          () => mockRepository.getContractors(
            any(),
            sortcontractors: any(named: 'sortcontractors'),
          ),
        ).thenAnswer(
          (_) async => <Contractor>[
            const Contractor(
              id: '1',
              companyName: 'test',
              address: 'test123',
              tags: ['hi'],
              phone: '123',
              licenses: [],
              totalRating: [],
            ),
          ],
        );
        return SearchBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const SearchSortPressed(sort: true)),
      expect: () => [
        const SearchState(status: SearchStateStatus.valid),
        const SearchState(status: SearchStateStatus.loading),
        const SearchState(
          contractors: [
            Contractor(
              id: '1',
              companyName: 'test',
              address: 'test123',
              tags: ['hi'],
              phone: '123',
              licenses: [],
              totalRating: [],
            ),
          ],
          status: SearchStateStatus.success,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'search filter pressed',
      build: () {
        when(
          () => mockRepository.getContractors(
            any(),
            sortcontractors: any(named: 'sortcontractors'),
          ),
        ).thenAnswer(
          (_) async => <Contractor>[
            const Contractor(
              id: '1',
              companyName: 'test',
              address: 'test123',
              tags: ['hi'],
              phone: '123',
              licenses: [],
              totalRating: [],
            ),
          ],
        );
        return SearchBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const SearchFilterPressed(filter: 100)),
      expect: () => [
        const SearchState(
          filter: 100,
          contractors: [
            Contractor(
              id: '1',
              companyName: 'test',
              address: 'test123',
              tags: ['hi'],
              phone: '123',
              licenses: [],
              totalRating: [],
            ),
          ],
          status: SearchStateStatus.success,
        ),
      ],
    );
  });
}
