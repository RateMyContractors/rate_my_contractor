import 'package:formz/formz.dart';

//this is all the wrong fields that we can have
enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  //represents unmotified form
  const Username.pure() : super.pure('');
  //represents modified form
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    return null;
  }
}
