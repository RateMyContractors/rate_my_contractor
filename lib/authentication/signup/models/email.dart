import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalidEmail }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  get invalid => null;

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(value)
        ? null
        : EmailValidationError.invalidEmail;
  }

  String validationError(EmailValidationError error) {
    if (error == EmailValidationError.empty) {
      return "Email can't be blank";
    } else if (error == EmailValidationError.invalidEmail) {
      return "Email requires an @";
    }
    return "";
  }
}
