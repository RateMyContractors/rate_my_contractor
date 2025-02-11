import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/models/user.dart';
import 'package:rate_my_contractor/authentication/logout/bloc/logout_bloc.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/contractor_list/data/models/license_dto.dart';
import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/contractor_page.dart';
import 'package:rate_my_contractor/results_page.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockLogOutBloc extends MockBloc<LogOutEvent, LogOutState>
    implements LogOutBloc {}

class MockReviewsBloc extends MockBloc<ReviewsEvent, ReviewsState>
    implements ReviewsBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late MockSearchBloc mockSearchBloc;
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockReviewsBloc mockReviewsBloc;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockReviewsBloc = MockReviewsBloc();
  });

  group('Reviewform test', () {
    testWidgets('Reviewform is present', (WidgetTester tester) async {
      when(() => mockAuthenticationBloc.state).thenReturn(
        const AuthenticationState.authenticated(
          user: User(
            userstatus: AuthenticationStatus.authenticated,
            id: '1234',
            email: '2233@gmail.com',
            username: 'mmomma',
            usertype: 'contractor',
          ),
        ),
      );

      when(() => mockReviewsBloc.state).thenReturn(const ReviewsState());

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
              totalRating: [],
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
              totalRating: [],
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<SearchBloc>.value(value: mockSearchBloc),
              BlocProvider<AuthenticationBloc>.value(
                value: mockAuthenticationBloc,
              ),
              BlocProvider<ReviewsBloc>.value(value: mockReviewsBloc),
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
      await tester.scrollUntilVisible(find.text('Write a review'), 100);
      await tester.tap(find.text('Write a review'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('"Z" ELECTRIC'));
      await tester.tap(find.text('Create Review'));
      await tester.tap(find.text('Overall Rating'));
    });
  });
}
