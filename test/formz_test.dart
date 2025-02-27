import 'package:flutter_test/flutter_test.dart';
import 'package:rate_my_contractor/authentication/login/models/email.dart';

void main() {
  group('forms input', () {
    test('Email Pure', () {
      const emailpure = Email.pure();
      expect(emailpure.value, '');
      expect(emailpure.isValid, false);
      expect(emailpure.error, EmailValidationError.empty);
    });
    test('Email dirty', () {
      const emailpure = Email.dirty('test');
      expect(emailpure.value, 'test');
      expect(emailpure.isValid, true);
      expect(emailpure.error, null);
    });
  });
}
