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
}
