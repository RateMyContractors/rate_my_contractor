import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/signup/bloc/signup_bloc.dart';
import 'package:rate_my_contractor/authentication/signup/models/email.dart';
import 'package:rate_my_contractor/authentication/signup/models/firstname.dart';
import 'package:rate_my_contractor/authentication/signup/models/lastname.dart';
import 'package:rate_my_contractor/authentication/signup/models/password.dart';
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
  });
}
/*

  FutureOr<void> _onUsernameChanged(
    SignUpUsernameChanged event,
    Emitter<SignUpState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([
          username,
          state.lastName,
          state.firstName,
          state.password,
          state.email,
        ]),
      ),
    );
  }

  FutureOr<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signUp(
          state.email.value,
          state.password.value,
          state.username.value,
          state.firstName.value,
          state.lastName.value,
          state.userType,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on Exception catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  FutureOr<void> _onUserTypeChanged(
    SignUpUserType event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(userType: event.userType));
  }
}
*/