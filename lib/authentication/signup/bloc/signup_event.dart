part of 'signup_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();
}

final class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class SignUpConfirmPasswordChanged extends SignUpEvent {
  const SignUpConfirmPasswordChanged(this.confirmpassword);

  final String confirmpassword;
  
  @override
  List<Object> get props => [confirmpassword];

  
}

final class SignUpFirstNameChanged extends SignUpEvent {
  const SignUpFirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class SignUpLastNameChanged extends SignUpEvent {
  const SignUpLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}



final class SignUpUsernameChanged extends SignUpEvent {
  const SignUpUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class SignUpSubmitted extends SignUpEvent {
  const SignUpSubmitted();

  @override
  List<Object?> get props => [];
}

final class SignUpUserType extends SignUpEvent {
  const SignUpUserType(this.userType);

  final String userType;

  @override
  List<Object> get props => [userType];
}
