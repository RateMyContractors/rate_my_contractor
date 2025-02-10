import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/main.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late MockSearchBloc mockSearchBloc;
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockAuthenticationRepository mockRepository;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockRepository = MockAuthenticationRepository();
  });

  group('Main page unauthenticated user view', () {
    test('repos initialize correctly', () {
      expect(mockRepository, isNotNull);
    });

    testWidgets('Displays login button', (WidgetTester tester) async {
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
            child: const MyHomePage(title: 'Contractor Home Page'),
          ),
        ),
      );
      expect(find.byType(MyHomePage), findsOneWidget);

      expect(find.text('Login'), findsOne);
    });
  });
}
