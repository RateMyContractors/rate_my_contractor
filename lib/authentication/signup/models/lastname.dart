import 'package:formz/formz.dart';

enum LastNameValidationError { empty, invalidLastName }

class LastName extends FormzInput<String, LastNameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([super.value = '']) : super.dirty();

  @override
  LastNameValidationError? validator(String value) {
    if (value.isEmpty) return LastNameValidationError.empty;
    final lastNameFormat = RegExp(r'^[a-zA-Z]+$');
    if (!lastNameFormat.hasMatch(value)) {
      return LastNameValidationError.invalidLastName;
    }
    return null;
  }
}
