part of 'signup_bloc.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.username = const Username.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final FirstName firstName;
  final LastName lastName;
  final Username username;
  final bool isValid;

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    FirstName? firstName,
    LastName? lastName,
    Username? username,
    bool? isValid,
  }) {
    return SignUpState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [status, email, password, firstName, lastName, username];
}
