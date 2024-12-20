part of 'signup_bloc.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.username = const Username.pure(),
    this.userType = 'User',
    this.isValid = false,
    //this.errormsg,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final FirstName firstName;
  final LastName lastName;
  final Username username;
  final String userType;
  final bool isValid;
  //final String? errormsg;
  

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    FirstName? firstName,
    LastName? lastName,
    Username? username,
    String? userType,
    bool? isValid,
    //String? errormsg,
  }) {

    return SignUpState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      userType: userType ?? this.userType,
      isValid: isValid ?? this.isValid,
      //errormsg: errormsg ?? this.errormsg,
    );
  }

  @override
  List<Object?> get props =>
      [status, email, password, firstName, lastName, username, userType];
}
