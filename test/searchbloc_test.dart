import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:test/test.dart';

void main() {
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
}
