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

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    if (!hasUppercase) return PasswordValidationError.noUppercase;

    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    if (!hasLowercase) return PasswordValidationError.noLowercase;

    final hasDigit = RegExp(r'[0-9]').hasMatch(value);
    if (!hasDigit) return PasswordValidationError.noDigit;

    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    if (!hasSpecialChar) return PasswordValidationError.noSpecialChar;

    return null;
  }

  String validationError(PasswordValidationError error) {
    if (error == PasswordValidationError.empty) {
      return "Password can't be blank";
    } else if (error == PasswordValidationError.invalidPassword) {
      return "Password length must be more than 8";
    } else if (error == PasswordValidationError.noUppercase) {
      return "Password must have Uppercase";
    } else if (error == PasswordValidationError.noLowercase) {
      return "Password must have Lowercase";
    } else if (error == PasswordValidationError.noDigit) {
      return "Password must have digits";
    } else if (error == PasswordValidationError.noSpecialChar) {
      return "Password must have special characters";
    }
    return "";
  }
}
