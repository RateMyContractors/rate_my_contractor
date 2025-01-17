// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:rate_my_contractor/authentication/bloc/authentication_bloc.dart';
// import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
// import 'package:rate_my_contractor/authentication/login/bloc/login_bloc.dart';
// import 'package:rate_my_contractor/authentication/login/screens/login_page.dart';
// import 'package:rate_my_contractor/authentication/signup/screens/signup_page.dart';
// import 'package:rate_my_contractor/contractor_list/bloc/search_bloc.dart';
// import 'package:rate_my_contractor/main.dart';

// class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
//     implements SearchBloc {}

// class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
//     implements LoginBloc {}

// class MockAuthenticationBloc
//     extends MockBloc<AuthenticationEvent, AuthenticationState>
//     implements AuthenticationBloc {}

// class MockAuthenticationRepository extends Mock
//     implements AuthenticationRepository {}

// void main() {
//   late MockSearchBloc mockSearchBloc;
//   late MockAuthenticationBloc mockAuthenticationBloc;
//   late MockLoginBloc mockLoginBloc;
//   late MockAuthenticationRepository mockAuthenticationRepository;

//   setUp(() {
//     mockSearchBloc = MockSearchBloc();
//     mockAuthenticationBloc = MockAuthenticationBloc();
//     mockLoginBloc = MockLoginBloc();
//     // Initial state setup
//     when(() => mockAuthenticationBloc.state)
//         .thenReturn(const AuthenticationState.unauthenticated());
//   });


//   group('Signup page Flow', () {
//     testWidgets('Contains Contractor and User button', (tester) async {
//       // Ensure the initial state is unauthenticated
//       when(() => mockAuthenticationBloc.state)
//           .thenReturn(const AuthenticationState.unauthenticated());

//       await tester.pumpWidget(
//         MaterialApp(
//           home: MultiBlocProvider(
//             providers: [
//               BlocProvider<SearchBloc>.value(value: mockSearchBloc),
//               BlocProvider<AuthenticationBloc>.value(
//                 value: mockAuthenticationBloc,
//               ),
//               BlocProvider<LoginBloc>.value(value: mockLoginBloc),
//             ],
//             child: const MyHomePage(title: 'Find who you need'),
//           ),
//           routes: {
//             '/login': (context) => BlocProvider<LoginBloc>.value(
//                   value: LoginBloc(authenticationRepository: mockAuthenticationRepository),
//                   child: const LoginPage(),
//                 ),
//             // '/signup': (context) => BlocProvider<AuthenticationBloc>.value(
//             //       value: mockAuthenticationBloc,
//             //       child: const SignupPage(),
//             //     ),
//           },
//         ),
//       );

//       // Navigate from landing page to login page
//       final loginButtonFinder = find.text('Login');
//       expect(loginButtonFinder, findsOneWidget);
//       await tester.tap(loginButtonFinder);
//       await tester.pumpAndSettle();
//       expect(find.byType(LoginPage), findsOneWidget);

//       // // Navigate from login page to sign up page
//       // final signupTextFinder = find.text('Sign up');
//       // expect(signupTextFinder, findsOneWidget);
//       // await tester.tap(signupTextFinder);
//       // await tester.pumpAndSettle();
//       // expect(find.byType(SignupPage), findsOneWidget);

//       //   // Verify the presence of the 'Contractor' and 'User' buttons
//       //   final contractorButtonFinder = find.text('Contractor');
//       //   final userButtonFinder = find.text('User');
//       //   expect(contractorButtonFinder, findsOneWidget);
//       //   expect(userButtonFinder, findsOneWidget);
//     });
//   });
// }
