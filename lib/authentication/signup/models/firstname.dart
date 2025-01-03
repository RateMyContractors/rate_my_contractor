import 'package:formz/formz.dart';

enum FirstNameValidationError { empty, invalidFirstName }

class FirstName extends FormzInput<String, FirstNameValidationError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([super.value = '']) : super.dirty();

  @override
  FirstNameValidationError? validator(String value) {
    if (value.isEmpty) return FirstNameValidationError.empty;
    final firstNameFormat = RegExp(r'^[a-zA-Z]+$');
    if (!firstNameFormat.hasMatch(value)) {
      return FirstNameValidationError.invalidFirstName;
    }
    return null;
  }

  String validationError(FirstNameValidationError error) {
    if (error == FirstNameValidationError.empty) {
      return "First name can't be blank";
    } else if (error == FirstNameValidationError.invalidFirstName) {
      return 'First name can only contain alphabetic characters';
    }
    return '';
  }
}
