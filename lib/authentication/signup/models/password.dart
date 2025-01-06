import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty,
  invalidPassword,
  invalidlength,
  noUppercase,
  noLowercase,
  noDigit,
  noSpecialChar,
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;

    if (value.length < 8) return PasswordValidationError.invalidPassword;

    final hasUppercase = RegExp('[A-Z]').hasMatch(value);
    if (!hasUppercase) return PasswordValidationError.noUppercase;

    final hasLowercase = RegExp('[a-z]').hasMatch(value);
    if (!hasLowercase) return PasswordValidationError.noLowercase;

    final hasDigit = RegExp('[0-9]').hasMatch(value);
    if (!hasDigit) return PasswordValidationError.noDigit;

    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    if (!hasSpecialChar) return PasswordValidationError.noSpecialChar;

    return null;
  }
}
