import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:rate_my_contractor/main.dart';
import 'package:rate_my_contractor/results_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';

//SetUp mockBloc to be passed thru pages
class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  late MockSearchBloc mockSearchBloc;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
  });

  group('ContractorPage Flow', () {
    testWidgets('Displays contractor cards and navigates to contractorpage',
        (WidgetTester tester) async {
      // Set initial state for the SearchBloc
      when(() => mockSearchBloc.state).thenReturn(
          const SearchState(status: SearchStateStatus.success, contractors: [
        Contractor(
          id: '845',
          companyName: '"Z" ELECTRIC',
          address: '10821 S KENTON AVE, OAK LAWN, IL 60453-',
          tags: ['Electrical Contractor (General)'],
          phone: '(708) 423-6967',
          totalRating: [1, 3],
          licenses: [
            LicenseDto(
              licenseNumber: 'ECC92504',
              licenseType: 'Electrical Contractor (General)',
              town: 'Oak Lawn',
              id: 'a629e63c-4c7b-4991-b2da-7ccb37c77cec',
              licenseExpiration: '2021-12-15',
              insuranceExpiration: null,
              isActive: 'true',
              contractorId: '845',
            ),
          ],
        ),
        Contractor(
          id: '123',
          companyName: 'ELIZABETH',
          address: '94 JOHN ST, HINDSDALE',
          tags: ['Electrical Contractor (General)'],
          phone: '(520)-956-1258',
          totalRating: [5, 3],
          licenses: [
            LicenseDto(
              licenseNumber: 'ECC92504',
              licenseType: 'Electrical Contractor (General)',
              town: 'Hindsdale',
              id: 'a6c',
              licenseExpiration: '2021-11-16',
              insuranceExpiration: null,
              isActive: 'true',
              contractorId: '123',
            ),
          ],
        )
      ]));

      //  Pump the ResultsPage with the mock bloc
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SearchBloc>.value(
            value: mockSearchBloc,
            child: const ResultsPage(),
          ),
          routes: {
            '/contractor': (context) => ContractorPage(
                contractor:
                    ModalRoute.of(context)!.settings.arguments as Contractor)
          },
        ),
      );

      //Verify ResultsPage
      expect(find.byType(ResultsPage), findsOneWidget);

      //Search for Z in SearchBar, Verify contractor cards are displayed
      await tester.enterText(find.byType(TextField), 'Z');
      expect(find.text('"Z" ELECTRIC'), findsOne);
      expect(find.text('ELIZABETH'), findsOne);
      await tester.pumpAndSettle();

      //See if tags are present on the cards
      expect(find.text('Electrical Contractor (General)'), findsWidgets);

      //Naviagte to ContractorPage by tapping on card
      await tester.tap(
        find
            .descendant(
              of: find.byType(ListView),
              matching: find.text('"Z" ELECTRIC'),
            )
            .first,
      );
      await tester.pumpAndSettle();

      //Verify navigation to ContractorPage
      expect(find.byType(ContractorPage), findsOneWidget);
      expect(find.text('"Z" ELECTRIC'), findsOneWidget);
      expect(find.text('(708) 423-6967'), findsOneWidget);
      expect(find.text('this is about us'), findsOneWidget);
    });

    testWidgets(
        'Search on HomePage and Navigate to ResultsPage, ContractorPage to show results',
        (WidgetTester tester) async {
      // Set the initial state
      when(() => mockSearchBloc.state).thenReturn(
        const SearchState(
          status: SearchStateStatus.success,
          contractors: [
            Contractor(
              id: '845',
              companyName: '"Z" ELECTRIC',
              address: '10821 S KENTON AVE, OAK LAWN, IL 60453-',
              tags: ['Electrical Contractor (General)'],
              phone: '(708) 423-6967',
              totalRating: [1, 3],
              licenses: [],
            ),
          ],
        ),
      );

      // Pump the MyHomePage with routes
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SearchBloc>.value(
            value: mockSearchBloc,
            child: const MyHomePage(title: 'Find who you need'),
          ),
          routes: {
            '/results': (context) => BlocProvider<SearchBloc>.value(
                  value: mockSearchBloc,
                  child: const ResultsPage(),
                ),
          },
        ),
      );

      // Verify HomePage
      expect(find.byType(MyHomePage), findsAtLeast(1));
      expect(find.text('Find who you need'), findsOneWidget);

      // Search for contractor in SearchBar, press SearchButton
      await tester.enterText(find.byType(SearchBar), '"Z" ELECTRIC');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Search'));
      await tester.pumpAndSettle();

      // Verify navigation to ResultsPage
      expect(find.byType(ResultsPage), findsOneWidget);

      //Naviagte to ContractorPage by tapping on card
      expect(find.text('"Z" ELECTRIC'), findsOneWidget);
      await tester.tap(find.text('"Z" ELECTRIC'));
      await tester.pumpAndSettle();

      //Verify navigation to ContractorPage
      expect(find.byType(ContractorPage), findsOneWidget);
      expect(find.text('"Z" ELECTRIC'), findsOneWidget);
      expect(find.text('(708) 423-6967'), findsOneWidget);
      expect(find.text('this is about us'), findsOneWidget);
    });
  });
}
