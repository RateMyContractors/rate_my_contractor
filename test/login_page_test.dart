import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/login/bloc/login_bloc.dart';

import 'package:rate_my_contractor/authentication/login/widgets/login_form.dart';
import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
import 'package:rate_my_contractor/main.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late MockSearchBloc mockSearchBloc;
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockLoginBloc mockLoginBloc;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockLoginBloc = MockLoginBloc();
    mockAuthenticationRepository = MockAuthenticationRepository();
  });

  group('Login page view', () {
    testWidgets('login page is available', (WidgetTester tester) async {
      when(() => mockAuthenticationBloc.state)
          .thenReturn(const AuthenticationState.unauthenticated());

      await tester.pumpWidget(
        RepositoryProvider<AuthenticationRepository>.value(
          value: mockAuthenticationRepository,
          child: MaterialApp(
            home: MultiBlocProvider(
              providers: [
                BlocProvider<SearchBloc>.value(value: mockSearchBloc),
                BlocProvider<AuthenticationBloc>.value(
                  value: mockAuthenticationBloc,
                ),
              ],
              child: const MyHomePage(title: 'Contractor Home Page'),
            ),
            routes: {
              '/login': (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<AuthenticationBloc>.value(
                        value: mockAuthenticationBloc,
                      ),
                      BlocProvider<LoginBloc>.value(value: mockLoginBloc),
                    ],
                    child: const LoginForm(),
                  ),
            },
          ),
        ),
      );
      expect(find.byType(MyHomePage), findsOneWidget);

      expect(find.text('Login'), findsOne);
      final loginButtonFinder = find.widgetWithText(TextButton, 'Login');
      await tester.tap(loginButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(LoginForm), findsOneWidget);

      const emailKey = Key('loginForm_emailInput_textField');
      const passwordKey = Key('loginForm_passwordInput_textField');
      const buttonKey = Key('loginForm_continue_raisedButton');

      final emailField = find.byKey(emailKey);
      final passwordField = find.byKey(passwordKey);
      final button = find.byKey(buttonKey);

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(button, findsOneWidget);
      expect(find.text('Login to get started'), findsOne);
    });
  });
}
