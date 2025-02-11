import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/signup/bloc/signup_bloc.dart';
import 'package:rate_my_contractor/authentication/signup/models/email.dart';
import 'package:rate_my_contractor/authentication/signup/models/firstname.dart';
import 'package:rate_my_contractor/authentication/signup/models/lastname.dart';
import 'package:rate_my_contractor/authentication/signup/models/password.dart';
import 'package:rate_my_contractor/authentication/signup/models/username.dart';
import 'package:test/test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  group(SignUpBloc, () {
    late SignUpBloc signUpBloc;
    late MockAuthenticationRepository mockRepository;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      signUpBloc = SignUpBloc(authenticationRepository: mockRepository);
    });

    test('initial state is ', () {
      expect(signUpBloc.state, equals(const SignUpState()));
    });

    blocTest<SignUpBloc, SignUpState>(
      'emits email and form validation',
      build: () => SignUpBloc(authenticationRepository: mockRepository),
      act: (bloc) => bloc.add(const SignUpEmailChanged('bridget@gmail.com')),
      expect: () => [
        const SignUpState(
          email: Email.dirty('bridget@gmail.com'),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits password changed valdation',
      build: () => SignUpBloc(authenticationRepository: mockRepository),
      act: (bloc) => bloc.add(const SignUpPasswordChanged('Bridget102610@')),
      expect: () => [
        const SignUpState(
          password: Password.dirty('Bridget102610@'),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits confirm password changed valdation',
      build: () => SignUpBloc(authenticationRepository: mockRepository),
      act: (bloc) =>
          bloc.add(const SignUpConfirmPasswordChanged('Bridget102610@')),
      expect: () => [
        const SignUpState(
          confirmpassword: Password.dirty('Bridget102610@'),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits First name changed valdation',
      build: () => SignUpBloc(authenticationRepository: mockRepository),
      act: (bloc) => bloc.add(const SignUpFirstNameChanged('Bridget')),
      expect: () => [
        const SignUpState(
          firstName: FirstName.dirty('Bridget'),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits Last name changed valdation',
      build: () => SignUpBloc(authenticationRepository: mockRepository),
      act: (bloc) => bloc.add(const SignUpLastNameChanged('last')),
      expect: () => [
        const SignUpState(
          lastName: LastName.dirty('last'),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits username changed valdation',
      build: () => SignUpBloc(authenticationRepository: mockRepository),
      act: (bloc) => bloc.add(const SignUpUsernameChanged('username10')),
      expect: () => [
        const SignUpState(
          username: Username.dirty('username10'),
        ),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits usertype changed valdation',
      build: () => SignUpBloc(authenticationRepository: mockRepository),
      act: (bloc) => bloc.add(const SignUpUserType('user')),
      expect: () => [
        const SignUpState(
          userType: 'user',
        ),
      ],
    );
  });
}
