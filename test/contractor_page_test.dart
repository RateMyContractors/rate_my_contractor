import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:rate_my_contractor/main.dart';
import 'package:rate_my_contractor/results_page.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late MockSearchBloc mockSearchBloc;
  late MockAuthenticationBloc mockAuthenticationBloc;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    mockAuthenticationBloc = MockAuthenticationBloc();
  });

  group('ContractorPage Flow', () {
    testWidgets('Displays contractor cards and navigates to contractorpage',
        (WidgetTester tester) async {
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
              licenses: [
                LicenseDto(
                  licenseNumber: 'ECC92504',
                  licenseType: 'Electrical Contractor (General)',
                  town: 'Oak Lawn',
                  id: 'a629e63c-4c7b-4991-b2da-7ccb37c77cec',
                  licenseExpiration: '2021-12-15',
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
              licenses: [
                LicenseDto(
                  licenseNumber: 'ECC92504',
                  licenseType: 'Electrical Contractor (General)',
                  town: 'Hindsdale',
                  id: 'a6c',
                  licenseExpiration: '2021-11-16',
                  isActive: 'true',
                  contractorId: '123',
                ),
              ],
            ),
          ],
        ),
      );
      when(() => mockAuthenticationBloc.state)
          .thenReturn(const AuthenticationState.unauthenticated());

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<SearchBloc>.value(value: mockSearchBloc),
              BlocProvider<AuthenticationBloc>.value(
                value: mockAuthenticationBloc,
              ),
            ],
            child: const ResultsPage(),
          ),
          routes: {
            '/contractor': (context) => ContractorPage(
                  contractor:
                      ModalRoute.of(context)!.settings.arguments! as Contractor,
                ),
          },
        ),
      );
      expect(find.byType(ResultsPage), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Z');
      expect(find.text('"Z" ELECTRIC'), findsOne);
      expect(find.text('ELIZABETH'), findsOne);
      await tester.pumpAndSettle();

      expect(find.text('Electrical Contractor (General)'), findsWidgets);

      await tester.tap(
        find
            .descendant(
              of: find.byType(ListView),
              matching: find.text('"Z" ELECTRIC'),
            )
            .first,
      );
      await tester.pumpAndSettle();

      expect(find.byType(ContractorPage), findsOneWidget);
      expect(find.text('"Z" ELECTRIC'), findsOneWidget);
      expect(find.text('(708) 423-6967'), findsOneWidget);
      expect(find.text('this is about us'), findsOneWidget);
    });

    testWidgets(
        'Search on HomePage and Navigate to ResultsPage, '
        'ContractorPage to show results', (WidgetTester tester) async {
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
              licenses: [],
            ),
          ],
        ),
      );
      when(() => mockAuthenticationBloc.state)
          .thenReturn(const AuthenticationState.unauthenticated());

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<SearchBloc>.value(value: mockSearchBloc),
              BlocProvider<AuthenticationBloc>.value(
                value: mockAuthenticationBloc,
              ),
            ],
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

      expect(find.byType(MyHomePage), findsAtLeast(1));
      expect(find.text('Find who you need'), findsOneWidget);

      await tester.enterText(find.byType(SearchBar), '"Z" ELECTRIC');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Search'));
      await tester.pumpAndSettle();

      expect(find.byType(ResultsPage), findsOneWidget);

      expect(find.text('"Z" ELECTRIC'), findsOneWidget);
      await tester.tap(find.text('"Z" ELECTRIC'));
      await tester.pumpAndSettle();

      expect(find.byType(ContractorPage), findsOneWidget);
      expect(find.text('"Z" ELECTRIC'), findsOneWidget);
      expect(find.text('(708) 423-6967'), findsOneWidget);
      expect(find.text('this is about us'), findsOneWidget);
    });
  });
}
