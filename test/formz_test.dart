import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/authentication/login/models/email.dart';
import 'package:rate_my_contractor/authentication/login/models/password.dart';

void main() {
  group('forms input', () {
    test('Email Pure', () {
      const emailpure = Email.pure();
      expect(emailpure.value, '');
      expect(emailpure.isValid, false);
      expect(emailpure.error, EmailValidationError.empty);
    });
    test('Email dirty', () {
      const emaildirty = Email.dirty('test');
      expect(emaildirty.value, 'test');
      expect(emaildirty.isValid, true);
      expect(emaildirty.error, null);
    });

    test('Password Pure', () {
      const passwordpure = Password.pure();
      expect(passwordpure.value, '');
      expect(passwordpure.isValid, false);
      expect(passwordpure.error, PasswordValidationError.empty);
    });
    test('Password dirty', () {
      const passworddirty = Email.dirty('test');
      expect(passworddirty.value, 'test');
      expect(passworddirty.isValid, true);
      expect(passworddirty.error, null);
    });
  });
}
