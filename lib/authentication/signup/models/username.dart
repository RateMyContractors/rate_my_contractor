import 'package:formz/formz.dart';

enum UsernameValidationError { empty, containsSpaces }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;

    if (value.contains(' ')) {
      return UsernameValidationError.containsSpaces;
    }
    return null;
  }

  String validationError(UsernameValidationError error) {
    if (error == UsernameValidationError.empty) {
      return "Username can't be blank";
    } else if (error == UsernameValidationError.containsSpaces) {
      return "Username can't contain spaces";
    }
    return '';
  }
}
