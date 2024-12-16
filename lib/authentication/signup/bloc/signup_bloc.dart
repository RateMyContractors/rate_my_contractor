import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rate_my_contractor/authentication/domain/authentication_repository.dart';
import 'package:rate_my_contractor/authentication/signup/models/email.dart';
import 'package:rate_my_contractor/authentication/signup/models/password.dart';
import 'package:rate_my_contractor/authentication/signup/models/lastname.dart';
import 'package:rate_my_contractor/authentication/signup/models/firstname.dart';
import 'package:rate_my_contractor/authentication/signup/models/username.dart';


part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpFirstNameChanged>(_onFirstNameChanged);
    on<SignUpLastNameChanged>(_onLastNameChanged);
    on<SignUpUsernameChanged>(_onUsernameChanged);
    on<SignUpSubmitted>(_onSubmitted);
  }
  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onEmailChanged(
      SignUpEmailChanged event, 
      Emitter<SignUpState> emit
      ) {
        final email = Email.dirty(event.email);
        emit(
          state.copyWith(
            email: email,
            isValid: Formz.validate([state.password, email]),
          ),
        );
      }

  FutureOr<void> _onPasswordChanged(
      SignUpPasswordChanged event, 
      Emitter<SignUpState> emit
    ) {
      final password = Password.dirty(event.password);
      emit(
        state.copyWith(
          password: password,
          isValid: Formz.validate([password, state.email]),
        ),
      );
  }

  FutureOr<void> _onFirstNameChanged(
      SignUpFirstNameChanged event, 
      Emitter<SignUpState> emit) {
      final firstName = FirstName.dirty(event.firstName);
      emit(
        state.copyWith(
          firstName: firstName,
          isValid: Formz.validate([firstName, state.password, state.email]),
        ),
      );
  }

  FutureOr<void> _onLastNameChanged(
      SignUpLastNameChanged event, 
      Emitter<SignUpState> emit) {
      final lastName = LastName.dirty(event.lastName);
      emit(
        state.copyWith(
          lastName: lastName,
          isValid: Formz.validate([lastName, state.firstName, state.password, state.email]),
        ),
      );
  }

  FutureOr<void> _onUsernameChanged(
      SignUpUsernameChanged event, 
      Emitter<SignUpState> emit) {
      final username = Username.dirty(event.username);
      emit(
        state.copyWith(
          username: username,
          isValid: Formz.validate([username, state.lastName, state.firstName, state.password, state.email]),
        ),
      );
  }

  FutureOr<void> _onSubmitted(
    SignUpSubmitted event, 
    Emitter<SignUpState> emit
    ) async {
      if (state.isValid) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        try {
          await _authenticationRepository.signUp(
            state.email.value,
            state.password.value,
            state.firstName.value,
            state.lastName.value,
            state.username.value,
          );
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } catch (_) {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      }
  }
}

//note u didnt add all the variables for each isvalid