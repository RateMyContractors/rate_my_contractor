import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:rate_my_contractor/results_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/contractor_page.dart';


class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}
void main(){ 
  late MockSearchBloc mockSearchBloc;

    setUp(() {
    mockSearchBloc = MockSearchBloc();
  });

  tearDown(() {
    mockSearchBloc.close();
  });

   group('Contractor Page Flow', () {
    testWidgets('Displays contractor cards and navigates to contractor details', (WidgetTester tester) async {
      // Step 1: Set initial state for the SearchBloc
      when(() => mockSearchBloc.state).thenReturn(
        const SearchState(
          isButtonOn: false,
          status: SearchStateStatus.initial,
          contractors: [], 
          query: '', 
          errormsg: '',
        ),
      );

      // Step 2: Pump the ResultsPage with the mock bloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SearchBloc>.value(
            value: mockSearchBloc,
            child: ResultsPage(),
          ),
          routes: {
            '/contractor': (context) => ContractorPage(contractor: null,),
          },
        ),
      );

      // Step 3: Verify contractor cards are displayed
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jane Smith'), findsOneWidget);

      // Step 4: Tap on a contractor card
      await tester.tap(find.text('John Doe'));
      await tester.pumpAndSettle();

      // Step 5: Verify navigation to ContractorPage
      expect(find.byType(ContractorPage), findsOneWidget);
    });
  });
}



// //testWidgets('Capture the query the user types', (tester)async{

//   testWidgets('Contractor card appears on the page', (tester)async{
//     await tester.pumpWidget(MaterialApp(
//       home: ContractorPage(contractor: testContractor),
//     ));
//     expect(find.text("Handy Home Repairs"), findsOneWidget);
//   });

//   testWidgets('About us appears on the page', (tester)async{
//     await tester.pumpWidget(MaterialApp(
//       home: ContractorPage(contractor: testContractor),
//     ));
//     expect(find.text("About Us\n"), findsOneWidget);
//   });

//   testWidgets('Portfolio appears on the page', (tester)async{
//     await tester.pumpWidget(MaterialApp(
//       home: ContractorPage(contractor: testContractor),
//     ));
//     await tester.pumpAndSettle();
//     expect(find.text("Portfolio\n"), findsOneWidget);
//   });
// }